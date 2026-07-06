import SwiftUI

struct HomeView: View {
    @ObservedObject var store: CitySpotsStore
    @State private var path: [HomeRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CitySpots")
                            .font(.largeTitle.bold())
                        Text("Find calm coffee bars, weekend walks and small city moments.")
                            .foregroundStyle(.secondary)
                    }

                    if store.isWeekendEditCardVisible {
                        HomeEditorialCard(
                            collection: store.weekendEdit,
                            spotCount: store.weekendEditSpots.count,
                            onTap: openWeekendEdit,
                            onDismiss: store.dismissWeekendEditCard
                        )
                        .onAppear {
                            store.trackWeekendEditCardShown()
                        }
                    }

                    Text("Featured today")
                        .font(.headline)

                    ForEach(store.featuredSpots) { spot in
                        NavigationLink(value: HomeRoute.spot(spot.id)) {
                            HomeSpotCard(spot: spot)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
            .navigationTitle("Home")
            .navigationDestination(for: HomeRoute.self) { route in
                destination(for: route)
            }
        }
    }

    private func openWeekendEdit() {
        store.trackWeekendEditCardTap()
        path.append(.weekendEdit)
    }

    @ViewBuilder
    private func destination(for route: HomeRoute) -> some View {
        switch route {
        case .weekendEdit:
            WeekendEditView(
                collection: store.weekendEdit,
                store: store
            )
        case let .spot(id):
            if let spot = store.spot(id: id) {
                SpotDetailView(
                    spot: spot,
                    store: store,
                    source: .home
                )
            } else {
                ContentUnavailableView {
                    Label("Spot unavailable", systemImage: "mappin.slash")
                } description: {
                    Text("This city spot is no longer available.")
                }
            }
        }
    }
}

private enum HomeRoute: Hashable {
    case weekendEdit
    case spot(SpotID)
}

private struct HomeSpotCard: View {
    let spot: Spot

    var body: some View {
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
}

#Preview {
    HomeView(store: CitySpotsStore())
}
