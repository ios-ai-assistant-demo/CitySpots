import Foundation

enum AppRoute: Equatable {
    case spotDetail(id: SpotID)
}

struct DeepLinkRouter {
    func route(_ url: URL) -> AppRoute? {
        guard url.scheme == "cityspots" else { return nil }
        return nil
    }
}
