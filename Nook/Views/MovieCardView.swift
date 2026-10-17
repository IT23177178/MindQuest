
import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    private let posterWidth: CGFloat = 340
    private let posterHeight: CGFloat = 500

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Image(movie.artworkName)
                .resizable()
                .scaledToFill()
                .frame(
                    width: posterWidth,
                    height: posterHeight
                )
                .clipped()
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            .white.opacity(0.12),
                            lineWidth: 1
                        )
                }

            Text(movie.title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .frame(
                    width: posterWidth,
                    height: 58,
                    alignment: .topLeading
                )
                .padding(.leading, 8)
        }
        .frame(
            width: posterWidth,
            alignment: .topLeading
        )
    }
}
