import Foundation
import Combine

enum DetailSource: String {
    case home
    case explore
    case weekendEdit = "weekend edit"
}

final class SpotDetailViewModel: ObservableObject {
    @Published private(set) var state: SpotDetailViewState

    private let store: CitySpotsStore

    init(
        spot: Spot,
        store: CitySpotsStore,
        converter: SpotLegalCopyConverting = SpotLegalCopyConverter()
    ) {
        self.store = store
        self.state = SpotDetailViewState(
            id: spot.id,
            title: spot.title,
            neighborhood: spot.neighborhood,
            summary: spot.summary,
            isFavorite: store.isFavorite(spot.id),
            legalCopy: converter.makeViewData(spot.legalCopy)
        )
    }

    func markOpened() {
        store.markOpened(state.id)
    }

    func toggleFavorite() {
        store.toggleFavorite(state.id)
        state = SpotDetailViewState(
            id: state.id,
            title: state.title,
            neighborhood: state.neighborhood,
            summary: state.summary,
            isFavorite: store.isFavorite(state.id),
            legalCopy: state.legalCopy
        )
    }
}
