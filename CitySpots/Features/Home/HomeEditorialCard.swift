import SwiftUI

struct HomeEditorialCard: View {
    let collection: EditorialCollection
    let spotCount: Int
    let onTap: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: onTap) {
                HStack(alignment: .top, spacing: 14) {
                    Image(systemName: "sparkles")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.blue)
                        .frame(width: 42, height: 42)
                        .background(.blue.opacity(0.12), in: Circle())

                    VStack(alignment: .leading, spacing: 8) {
                        Text(collection.title)
                            .font(.title3.bold())
                            .foregroundStyle(.primary)

                        Text(collection.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Label("\(spotCount) stops", systemImage: "mappin.and.ellipse")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
                .padding(.trailing, 28)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [
                            Color.blue.opacity(0.14),
                            Color.green.opacity(0.10)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    in: RoundedRectangle(cornerRadius: 18)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.blue.opacity(0.12), lineWidth: 1)
                }
                .contentShape(RoundedRectangle(cornerRadius: 18))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(collection.title)
            .accessibilityHint(collection.subtitle)

            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 44, height: 44)
            .contentShape(Circle())
            .buttonStyle(.plain)
            .accessibilityLabel("Dismiss \(collection.title)")
        }
    }
}

#Preview {
    HomeEditorialCard(
        collection: SampleData.weekendEdit,
        spotCount: 3,
        onTap: {},
        onDismiss: {}
    )
    .padding()
}
