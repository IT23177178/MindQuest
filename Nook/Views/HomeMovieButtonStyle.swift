
import SwiftUI

struct HomeMovieButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HomeMovieButtonLabel(label: configuration.label)
    }
}

private struct HomeMovieButtonLabel<Label: View>: View {
    @Environment(\.isFocused) private var isFocused

    let label: Label

    var body: some View {
        label
            .scaleEffect(isFocused ? 1.05 : 1.0)
            .shadow(
                color: .black.opacity(isFocused ? 0.5 : 0),
                radius: 20,
                y: 12
            )
            .animation(
                .easeOut(duration: 0.2),
                value: isFocused
            )
    }
}
