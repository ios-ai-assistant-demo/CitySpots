import Foundation
import Combine

final class CitySpotsStore: ObservableObject {
    @Published private(set) var spots: [Spot]
    @Published private(set) var favoriteIDs: Set<SpotID>
    @Published private(set) var lastOpenedSpotID: SpotID?
    @Published private(set) var selectedCategories: Set<SpotCategory>
    @Published private(set) var isFavoritesOnly: Bool
    @Published private(set) var exploreSort: ExploreSortOption

    private let defaults: UserDefaults

    private enum DefaultsKey {
        static let selectedCategories = "explore.selectedCategories"
        static let isFavoritesOnly = "explore.isFavoritesOnly"
        static let sort = "explore.sort"
    }

    private static let defaultCategories = Set(SpotCategory.allCases)

    init(
        spots: [Spot] = SampleData.spots,
        favoriteIDs: Set<SpotID> = ["riverside-brew"],
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
        self.spots = spots
        self.favoriteIDs = favoriteIDs

        let persistedCategories = defaults.array(forKey: DefaultsKey.selectedCategories) as? [String]
        if let persistedCategories {
            selectedCategories = Set(persistedCategories.compactMap(SpotCategory.init(rawValue:)))
        } else {
            selectedCategories = Self.defaultCategories
        }

        if defaults.object(forKey: DefaultsKey.isFavoritesOnly) != nil {
            isFavoritesOnly = defaults.bool(forKey: DefaultsKey.isFavoritesOnly)
        } else {
            isFavoritesOnly = false
        }

        let persistedSort = defaults.string(forKey: DefaultsKey.sort)
        exploreSort = ExploreSortOption(rawValue: persistedSort ?? "") ?? .recommended
    }

    var featuredSpots: [Spot] {
        Array(spots.prefix(3))
    }

    var exploreSpots: [Spot] {
        var filteredSpots = spots.filter { selectedCategories.contains($0.category) }

        if isFavoritesOnly {
            filteredSpots = filteredSpots.filter { favoriteIDs.contains($0.id) }
        }

        switch exploreSort {
        case .recommended:
            return filteredSpots
        case .title:
            return filteredSpots.sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }
        case .neighborhood:
            return filteredSpots.sorted { lhs, rhs in
                let neighborhoodOrder = lhs.neighborhood.localizedCaseInsensitiveCompare(rhs.neighborhood)
                if neighborhoodOrder == .orderedSame {
                    return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
                }
                return neighborhoodOrder == .orderedAscending
            }
        case .category:
            return filteredSpots.sorted { lhs, rhs in
                let categoryOrder = lhs.category.title.localizedCaseInsensitiveCompare(rhs.category.title)
                if categoryOrder == .orderedSame {
                    return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
                }
                return categoryOrder == .orderedAscending
            }
        }
    }

    var activeExploreFilterCount: Int {
        var count = 0

        if selectedCategories != Self.defaultCategories {
            count += 1
        }

        if isFavoritesOnly {
            count += 1
        }

        return count
    }

    func isFavorite(_ id: SpotID) -> Bool {
        favoriteIDs.contains(id)
    }

    func toggleFavorite(_ id: SpotID) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
    }

    func markOpened(_ id: SpotID) {
        lastOpenedSpotID = id
    }

    func spot(id: SpotID) -> Spot? {
        spots.first { $0.id == id }
    }

    func isCategorySelected(_ category: SpotCategory) -> Bool {
        selectedCategories.contains(category)
    }

    func toggleCategorySelection(_ category: SpotCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }

        persistExplorePreferences()
    }

    func setFavoritesOnly(_ isFavoritesOnly: Bool) {
        self.isFavoritesOnly = isFavoritesOnly
        persistExplorePreferences()
    }

    func setExploreSort(_ sort: ExploreSortOption) {
        exploreSort = sort
        persistExplorePreferences()
    }

    func resetExploreFilters() {
        selectedCategories = Self.defaultCategories
        isFavoritesOnly = false
        persistExplorePreferences()
    }

    private func persistExplorePreferences() {
        defaults.set(selectedCategories.map(\.rawValue).sorted(), forKey: DefaultsKey.selectedCategories)
        defaults.set(isFavoritesOnly, forKey: DefaultsKey.isFavoritesOnly)
        defaults.set(exploreSort.rawValue, forKey: DefaultsKey.sort)
    }
}
