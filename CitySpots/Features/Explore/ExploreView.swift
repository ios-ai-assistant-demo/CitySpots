import SwiftUI

struct ExploreView: View {
    @ObservedObject var store: CitySpotsStore
    @State private var isShowingFilterSheet = false

    var body: some View {
        NavigationStack {
            Group {
                if store.exploreSpots.isEmpty {
                    ContentUnavailableView {
                        Label("No spots found", systemImage: "line.3.horizontal.decrease.circle")
                    } description: {
                        Text("Try changing filters or reset them to explore all places again.")
                    } actions: {
                        Button("Reset filters") {
                            store.resetExploreFilters()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(store.exploreSpots) { spot in
                            NavigationLink {
                                SpotDetailView(
                                    spot: spot,
                                    store: store,
                                    source: .explore
                                )
                            } label: {
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(spot.title)
                                            .font(.headline)
                                        Spacer()
                                        Text(spot.category.title)
                                            .font(.caption.weight(.medium))
                                            .foregroundStyle(.secondary)
                                    }

                                    Text(spot.summary)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)

                                    Text(spot.neighborhood)
                                        .font(.caption)
                                        .foregroundStyle(.tertiary)
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Explore")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingFilterSheet = true
                    } label: {
                        Label("Filter / Sort", systemImage: "line.3.horizontal.decrease.circle")
                            .overlay(alignment: .topTrailing) {
                                if store.activeExploreFilterCount > 0 {
                                    Text("\(store.activeExploreFilterCount)")
                                        .font(.caption2.bold())
                                        .foregroundStyle(.white)
                                        .padding(5)
                                        .background(.blue, in: Circle())
                                        .offset(x: 10, y: -10)
                                }
                            }
                    }
                }
            }
            .sheet(isPresented: $isShowingFilterSheet) {
                ExploreFilterSortSheet(store: store)
            }
        }
    }
}

private struct ExploreFilterSortSheet: View {
    @ObservedObject var store: CitySpotsStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("Sort") {
                    ForEach(ExploreSortOption.allCases) { option in
                        Button {
                            store.setExploreSort(option)
                        } label: {
                            HStack {
                                Text(option.title)
                                    .foregroundStyle(.primary)
                                Spacer()
                                if store.exploreSort == option {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                }

                Section("Filters") {
                    Toggle(
                        "Favorites only",
                        isOn: Binding(
                            get: { store.isFavoritesOnly },
                            set: store.setFavoritesOnly
                        )
                    )

                    ForEach(SpotCategory.allCases) { category in
                        Button {
                            store.toggleCategorySelection(category)
                        } label: {
                            HStack {
                                Text(category.title)
                                    .foregroundStyle(.primary)
                                Spacer()
                                if store.isCategorySelected(category) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filter / Sort")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if store.activeExploreFilterCount > 0 {
                        Button("Reset filters") {
                            store.resetExploreFilters()
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView(store: CitySpotsStore())
}
