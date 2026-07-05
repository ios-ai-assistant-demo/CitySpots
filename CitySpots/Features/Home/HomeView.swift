import SwiftUI

struct HomeView: View {
    @ObservedObject var store: CitySpotsStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CitySpots")
                            .font(.largeTitle.bold())
                        Text("Find calm coffee bars, weekend walks and small city moments.")
                            .foregroundStyle(.secondary)
                    }

                    Text("Featured today")
                        .font(.headline)

                    ForEach(store.featuredSpots) { spot in
                        NavigationLink {
                            SpotDetailView(
                                spot: spot,
                                store: store,
                                source: .home
                            )
                        } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
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
                                    .foregroundStyle(.secondary)

                                Text(spot.neighborhood)
                                    .font(.caption)
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(store: CitySpotsStore())
}
