import Foundation

enum EditorialCardAnalyticsAction: String {
    case show
    case tap
    case dismiss
}

struct CitySpotsAnalyticsEvent {
    let name: String
    let parameters: [String: String]
}

protocol CitySpotsAnalyticsTracking {
    func track(_ event: CitySpotsAnalyticsEvent)
}

struct ConsoleCitySpotsAnalyticsTracker: CitySpotsAnalyticsTracking {
    func track(_ event: CitySpotsAnalyticsEvent) {
        let parameters = event.parameters
            .sorted { $0.key < $1.key }
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: " ")

        print("[Analytics] \(event.name) \(parameters)")
    }
}

extension CitySpotsAnalyticsEvent {
    static func weekendEditCard(
        _ action: EditorialCardAnalyticsAction,
        collectionID: EditorialCollectionID
    ) -> CitySpotsAnalyticsEvent {
        CitySpotsAnalyticsEvent(
            name: "weekend_edit_card",
            parameters: [
                "action": action.rawValue,
                "collection_id": collectionID
            ]
        )
    }
}
