import Foundation

typealias EditorialCollectionID = String

struct EditorialCollection: Identifiable, Hashable {
    let id: EditorialCollectionID
    let title: String
    let subtitle: String
    let summary: String
    let spotIDs: [SpotID]
}
