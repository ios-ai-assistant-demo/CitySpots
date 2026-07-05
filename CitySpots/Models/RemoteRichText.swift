import Foundation

struct RemoteRichText: Hashable {
    let spans: [RemoteRichTextSpan]
}

struct RemoteRichTextSpan: Hashable {
    enum Style: Hashable {
        case body
        case link(URL)
    }

    let text: String
    let style: Style
}
