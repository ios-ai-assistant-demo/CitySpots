import SwiftUI

struct WeekendEditView: View {
    let collection: EditorialCollection
    @ObservedObject var store: CitySpotsStore

    private var spots: [Spot] {
        store.spots(for: collection)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(collection.title)
                        .font(.largeTitle.bold())

                    Text(collection.summary)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                if spots.isEmpty {
                    ContentUnavailableView {
                        Label("No stops available", systemImage: "mappin.slash")
                    } description: {
                        Text("This edit does not have any active city spots right now.")
                    }
                } else {
                    VStack(spacing: 14) {
                        ForEach(spots) { spot in
                            NavigationLink {
                                SpotDetailView(
                                    spot: spot,
                                    store: store,
                                    source: .weekendEdit
                                )
                            } label: {
                                WeekendEditSpotCard(spot: spot)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(collection.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct WeekendEditSpotCard: View {
    let spot: Spot

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(spot.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Text(spot.category.title)
                    .font(.caption.weight(.medium))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue.opacity(0.12), in: Capsule())
            }

            Text(spot.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(spacing: 6) {
                Image(systemName: "location")
                Text(spot.neighborhood)
            }
            .font(.caption)
            .foregroundStyle(.tertiary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    NavigationStack {
        WeekendEditView(
            collection: SampleData.weekendEdit,
            store: CitySpotsStore()
        )
    }
}
