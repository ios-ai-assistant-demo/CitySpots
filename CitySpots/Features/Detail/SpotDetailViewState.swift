import Foundation

struct SpotDetailViewState {
    let id: SpotID
    let title: String
    let neighborhood: String
    let summary: String
    let isFavorite: Bool
    let legalCopy: SpotLegalCopyViewData?
}

struct SpotLegalCopyViewData {
    let text: AttributedString
    let accessibilityLabel: String
}
