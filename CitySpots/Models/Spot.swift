import Foundation

typealias SpotID = String

enum SpotCategory: String, CaseIterable, Identifiable {
    case coffee
    case exhibition
    case walk
    case food
    case market

    var id: String { rawValue }

    var title: String {
        switch self {
        case .coffee:
            return "Coffee"
        case .exhibition:
            return "Exhibitions"
        case .walk:
            return "Walks"
        case .food:
            return "Food"
        case .market:
            return "Markets"
        }
    }
}

enum ExploreSortOption: String, CaseIterable, Identifiable {
    case recommended
    case title
    case neighborhood
    case category

    var id: String { rawValue }

    var title: String {
        switch self {
        case .recommended:
            return "Recommended"
        case .title:
            return "Title"
        case .neighborhood:
            return "Neighborhood"
        case .category:
            return "Category"
        }
    }
}

struct Spot: Identifiable, Hashable {
    let id: SpotID
    let title: String
    let neighborhood: String
    let category: SpotCategory
    let summary: String
    let tags: [String]
    let legalCopy: RemoteRichText?
}
