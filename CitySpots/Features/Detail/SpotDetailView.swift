import SwiftUI

struct SpotDetailView: View {
    @StateObject private var viewModel: SpotDetailViewModel

    init(spot: Spot, store: CitySpotsStore, source: DetailSource) {
        _viewModel = StateObject(wrappedValue: SpotDetailViewModel(spot: spot, store: store))
        self.source = source
    }

    private let source: DetailSource

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.state.title)
                        .font(.largeTitle.bold())
                    Text(viewModel.state.neighborhood)
                        .foregroundStyle(.secondary)
                }

                Text(viewModel.state.summary)
                    .font(.body)

                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Label(
                        viewModel.state.isFavorite ? "Saved to favorites" : "Save to favorites",
                        systemImage: viewModel.state.isFavorite ? "heart.fill" : "heart"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                if let legalCopy = viewModel.state.legalCopy {
                    SpotLegalCopyFooter(viewData: legalCopy)
                }
            }
            .padding(20)
        }
        .navigationTitle("Spot")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.markOpened()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text(source.rawValue.capitalized)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
