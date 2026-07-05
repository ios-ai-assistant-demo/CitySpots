import Foundation
import SwiftUI

protocol SpotLegalCopyConverting {
    func makeViewData(_ remote: RemoteRichText?) -> SpotLegalCopyViewData?
}

struct SpotLegalCopyConverter: SpotLegalCopyConverting {
    func makeViewData(_ remote: RemoteRichText?) -> SpotLegalCopyViewData? {
        guard let remote else {
            return nil
        }

        var result = AttributedString()
        var accessibilityChunks: [String] = []

        for span in remote.spans {
            var chunk = AttributedString(span.text)

            switch span.style {
            case .body:
                break
            case .link(let url):
                chunk.foregroundColor = .blue
                chunk.underlineStyle = .single
                chunk.link = url
            }

            accessibilityChunks.append(span.text)
            result.append(chunk)
        }

        return SpotLegalCopyViewData(
            text: result,
            accessibilityLabel: accessibilityChunks.joined()
        )
    }
}
