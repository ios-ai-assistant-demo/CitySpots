import SwiftUI

struct ContentView: View {
    @ObservedObject var store: CitySpotsStore

    var body: some View {
        TabView {
            HomeView(store: store)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ExploreView(store: store)
                .tabItem {
                    Label("Explore", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView(store: CitySpotsStore())
}
