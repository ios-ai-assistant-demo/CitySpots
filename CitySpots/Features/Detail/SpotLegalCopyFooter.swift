import SwiftUI

struct SpotLegalCopyFooter: View {
    let viewData: SpotLegalCopyViewData

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Before you go")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Text(viewData.text)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .accessibilityLabel(viewData.accessibilityLabel)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
    }
}
