
import SwiftUI
import AVKit

struct MovieDetailView: View {
    let movie: Movie

    @State private var videoService = VideoPlayerService()
    @State private var isPlayerPresented = false
    @State private var isResumePromptPresented = false

    private let primaryText = Color.white
    private let secondaryText = Color.white.opacity(0.80)

    private let sectionSpacing: CGFloat = 28
    private let recommendationSpacing: CGFloat = 32
    private let cardWidth: CGFloat = 340
    private let cardHeight: CGFloat = 500

    private var isSnowBear: Bool {
        movie.title == "Snow Bear"
    }

    var body: some View {
        GeometryReader { geometry in
            let posterWidth = geometry.size.width * 0.30
            let posterHeight = geometry.size.height * 0.84

            ZStack {
                Color.black
                    .ignoresSafeArea()

                HStack(alignment: .center, spacing: 52) {
                    posterSection(
                        width: posterWidth,
                        height: posterHeight
                    )

                    detailsPanel
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                }
                .padding(.horizontal, 70)
                .padding(.vertical, 45)
            }
        }
        .preferredColorScheme(.dark)
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(
            isPresented: $isPlayerPresented,
            onDismiss: {
                videoService.stop()
            }
        ) {
            playerScreen
        }
        .confirmationDialog(
            "Continue watching Snow Bear?",
            isPresented: $isResumePromptPresented,
            titleVisibility: .visible
        ) {
            Button("Continue Watching") {
                videoService.resumeFromSavedPosition {
                    isPlayerPresented = true
                }
            }

            Button("Start from Beginning") {
                videoService.startFromBeginning()
                isPlayerPresented = true
            }

            Button("Cancel", role: .cancel) {
                // Keep the saved playback position.
            }
        } message: {
            Text(
                "Would you like to pick up where you left off or watch from the beginning?"
            )
        }
    }

    // MARK: - Poster

    private func posterSection(
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        VStack(spacing: 20) {
            Image(movie.artworkName)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            .white.opacity(0.18),
                            lineWidth: 1
                        )
                }

            if movie.isPlayable {
                Button {
                    startPlayback()
                } label: {
                    Label("Play", systemImage: "play.fill")
                        .font(
                            .system(size: 21, weight: .semibold)
                        )
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            .white,
                            in: RoundedRectangle(cornerRadius: 9)
                        )
                }
                .buttonStyle(.card)
            } else {
                Text("Not available to play")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(secondaryText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
            }
        }
        .frame(width: width)
    }

    // MARK: - Right Side

    private var detailsPanel: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: sectionSpacing) {
                titleSection

                overviewSection

                if isSnowBear {
                    creditsSection
                }

                recommendationSection
            }
            .frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
            .padding(.bottom, 30)
        }
        .scrollIndicators(.hidden)
    }

    // MARK: - Title and Chips

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(movie.title)
                .font(.system(size: 50, weight: .bold))
                .tracking(-0.8)
                .foregroundStyle(primaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )

            HStack(spacing: 10) {
                metadataChip("Animated Short")
                metadataChip("Family")
                metadataChip(movie.mood)
            }

            Text(movie.subtitle)
                .font(.system(size: 21, weight: .regular))
                .foregroundStyle(secondaryText)
                .lineSpacing(3)
                .lineLimit(3)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
    }

    private func metadataChip(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(.white.opacity(0.95))
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(
                .white.opacity(0.12),
                in: Capsule()
            )
            .overlay {
                Capsule()
                    .strokeBorder(
                        .white.opacity(0.16),
                        lineWidth: 1
                    )
            }
            .fixedSize()
    }

    // MARK: - Overview

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Overview")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white.opacity(0.72))
                .textCase(.uppercase)
                .tracking(1.5)

            Text("About this story")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(primaryText)

            Text(
                isSnowBear
                    ? "The story of a lonely polar bear in an unforgiving environment on his quest to find a friend."
                    : movie.description
            )
            .font(.system(size: 21, weight: .regular))
            .foregroundStyle(secondaryText)
            .lineSpacing(6)
            .fixedSize(
                horizontal: false,
                vertical: true
            )
            .frame(maxWidth: 760, alignment: .leading)
        }
    }

    // MARK: - Film Credits

    private var creditsSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            detailRow(label: "Creator / Director") {
                Link(
                    "Aaron Blaise",
                    destination: URL(
                        string: "https://www.google.com/search?q=Aaron+Blaise"
                    )!
                )
                .font(.system(size: 19, weight: .medium))
                .foregroundStyle(.white)
            }

            detailRow(label: "Running time") {
                Text("11 minutes")
                    .font(.system(size: 19, weight: .medium))
                    .foregroundStyle(primaryText)
            }
        }
    }

    private func detailRow<Value: View>(
        label: String,
        @ViewBuilder value: () -> Value
    ) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 18) {
            Text(label)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.white.opacity(0.65))
                .frame(width: 190, alignment: .leading)

            value()
        }
    }

    // MARK: - Recommendations

    private var recommendationSection: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text("You might also like")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(primaryText)

            if recommendations.isEmpty {
                Text("More stories coming soon.")
                    .font(.system(size: 19))
                    .foregroundStyle(secondaryText)
            } else {
                ScrollView(.horizontal) {
                    HStack(
                        alignment: .top,
                        spacing: recommendationSpacing
                    ) {
                        ForEach(recommendations) { recommendation in
                            NavigationLink {
                                MovieDetailView(movie: recommendation)
                            } label: {
                                recommendationCard(recommendation)
                            }
                            .buttonStyle(LiftOnFocusButtonStyle())


                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }

    private var recommendations: [Movie] {
        HomeViewModel().movies.filter { candidate in
            candidate.title != movie.title
        }
    }

    private func recommendationCard(
        _ recommendation: Movie
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(recommendation.artworkName)
                .resizable()
                .scaledToFill()
                .frame(
                    width: cardWidth,
                    height: cardHeight
                )
                .clipped()
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            .white.opacity(0.16),
                            lineWidth: 1
                        )
                }


            Text(recommendation.title)
                .font(.system(size: 23, weight: .semibold))
                .foregroundStyle(primaryText)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .frame(
                    width: cardWidth,
                    alignment: .topLeading
                )

        }
        .frame(
            width: cardWidth,
            alignment: .topLeading
        )
        .contentShape(Rectangle())
        .focusEffectDisabled()
    }

    // MARK: - Playback

    private var playerScreen: some View {
        Group {
            if let player = videoService.player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onAppear {
                        videoService.play()
                    }
            } else {
                ZStack {
                    Color.black
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Unable to play this story")
                            .font(.title2)
                            .foregroundStyle(.white)

                        Button("Close") {
                            isPlayerPresented = false
                        }
                    }
                }
            }
        }
    }

    private func startPlayback() {
        guard movie.isPlayable else { return }

        guard videoService.loadVideo(named: "SnowBear") else {
            return
        }

        if videoService.hasSavedProgress {
            isResumePromptPresented = true
        } else {
            isPlayerPresented = true
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(
            movie: Movie(
                title: "Snow Bear",
                subtitle: "A little story about friendship",
                mood: "Wind Down",
                description: "A gentle animated story about a polar bear discovering the world around him.",
                artworkName: "snow-bear",
                isPlayable: true
            )
        )
    }
}
private struct NoPlatterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
private struct LiftOnFocusButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        LiftOnFocusLabel(label: configuration.label)
    }
}

private struct LiftOnFocusLabel<Label: View>: View {
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
            .animation(.easeOut(duration: 0.2), value: isFocused)
    }
}
