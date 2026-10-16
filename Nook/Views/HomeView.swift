
//
//  HomeView.swift
//  Nook
//

import SwiftUI
import AVKit
import UIKit

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var previewPlayer = AVQueuePlayer()
    @State private var previewLooper: AVPlayerLooper?

    private let backgroundColor = Color.black
    private let accentColor = Color.white

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()

                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 58) {
                        // Full-width hero, including the header.
                        if let movie = viewModel.featuredMovie {
                            featuredSection(movie)
                        }

                        // Content below the hero.
                        VStack(alignment: .leading, spacing: 58) {
                            moodSection

                            movieSection(
                                title: "A little comfort",
                                subtitle: "Stories for slower moments",
                                movies: viewModel.movies(
                                    for: viewModel.moods[0]
                                )
                            )

                            movieSection(
                                title: "Beyond the ordinary",
                                subtitle: "Discover another world",
                                movies: viewModel.movies(
                                    for: viewModel.moods[1]
                                )
                            )

                            movieSection(
                                title: "Closer to nature",
                                subtitle: "Find beauty in the world around us",
                                movies: viewModel.movies(
                                    for: viewModel.moods[2]
                                )
                            )

                            movieSection(
                                title: "Wind Down",
                                subtitle: "Gentle stories for quieter moments",
                                movies: viewModel.movies(
                                    for: viewModel.moods[3]
                                )
                            )
                        }
                        .padding(.horizontal, 72)
                    }
                    .padding(.bottom, 90)
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea(edges: .top)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
        .onDisappear {
            previewPlayer.pause()
        }
    }

    // MARK: - Full-Bleed Featured Banner

    private func featuredSection(_ movie: Movie) -> some View {
        NavigationLink {
            MovieDetailView(movie: movie)
        } label: {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    // Full-width looping video.
                    Color.black

                    LoopingVideoBackground(
                        player: previewPlayer
                    )
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .clipped()

                    // Darken the whole banner and add extra
                    // contrast behind the text.
                    LinearGradient(
                        stops: [
                            .init(
                                color: .black.opacity(0.70),
                                location: 0
                            ),
                            .init(
                                color: .black.opacity(0.28),
                                location: 0.42
                            ),
                            .init(
                                color: .black.opacity(0.12),
                                location: 0.68
                            ),
                            .init(
                                color: .black.opacity(0.92),
                                location: 1
                            )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    LinearGradient(
                        stops: [
                            .init(
                                color: .black.opacity(0.65),
                                location: 0
                            ),
                            .init(
                                color: .black.opacity(0.20),
                                location: 0.65
                            ),
                            .init(
                                color: .clear,
                                location: 1
                            )
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )

                    VStack(alignment: .leading, spacing: 0) {
                        // Header sits directly on the video.
                        HStack(alignment: .center) {
                            Text("nook")
                                .font(
                                    .system(
                                        size: 38,
                                        weight: .bold
                                    )
                                )
                                .tracking(-1.4)
                                .foregroundStyle(.white)

                            Spacer()

                            Text("A little escape.")
                                .font(
                                    .system(
                                        size: 21,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(
                                    .white.opacity(0.95)
                                )
                        }
                        .padding(.top, 58)

                        Spacer(minLength: 40)

                        // Featured story details.
                        VStack(alignment: .leading, spacing: 20) {
                            HStack(spacing: 10) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(.white)
                                    .frame(width: 4, height: 20)

                                Text("FEATURED")
                                    .font(
                                        .system(
                                            size: 16,
                                            weight: .bold
                                        )
                                    )
                                    .tracking(3)
                                    .foregroundStyle(.white)
                            }

                            Text(movie.title)
                                .font(
                                    .system(
                                        size: 58,
                                        weight: .bold
                                    )
                                )
                                .tracking(-1.5)
                                .foregroundStyle(.white)
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)

                            Text(movie.subtitle)
                                .font(
                                    .system(
                                        size: 25,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(
                                    .white.opacity(0.92)
                                )
                                .lineLimit(2)

                            Text(movie.description)
                                .font(.system(size: 19))
                                .foregroundStyle(
                                    .white.opacity(0.82)
                                )
                                .lineLimit(3)
                                .frame(
                                    maxWidth: 580,
                                    alignment: .leading
                                )

                            HStack(spacing: 12) {
                                Image(systemName: "play.fill")
                                    .font(
                                        .system(
                                            size: 17,
                                            weight: .bold
                                        )
                                    )

                                Text("Explore story")
                                    .font(
                                        .system(
                                            size: 20,
                                            weight: .semibold
                                        )
                                    )
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 18)
                            .background(
                                .white,
                                in: RoundedRectangle(
                                    cornerRadius: 7
                                )
                            )
                            .padding(.top, 5)
                        }

                        Spacer(minLength: 55)
                    }
                    .padding(.horizontal, 80)
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .clipped()
            }
            // Taller hero; its image reaches both side edges.
            .frame(height: 760)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.card)
        .accessibilityLabel(
            "Explore featured story: \(movie.title)"
        )
        .onAppear {
            startFeaturedPreview()
        }
        .onDisappear {
            previewPlayer.pause()
        }
    }

    // MARK: - Featured Video Setup

    private func startFeaturedPreview() {
        if !previewPlayer.items().isEmpty {
            previewPlayer.play()
            return
        }

        guard let url = Bundle.main.url(
            forResource: "SnowBear",
            withExtension: "mp4"
        ) else {
            print(
                "Nook: SnowBear.mp4 was not found in the app bundle."
            )
            return
        }

        let item = AVPlayerItem(url: url)

        previewPlayer.isMuted = true

        previewLooper = AVPlayerLooper(
            player: previewPlayer,
            templateItem: item
        )

        previewPlayer.play()
    }

    // MARK: - Mood Selection

    private var moodSection: some View {
        VStack(alignment: .leading, spacing: 26) {
            sectionHeading(
                "Find your kind of moment",
                subtitle: "Choose what feels right for you"
            )

            ScrollView(.horizontal) {
                HStack(spacing: 28) {
                    ForEach(viewModel.moods) { mood in
                        NavigationLink {
                            MoodMoviesView(
                                mood: mood,
                                movies: viewModel.movies(for: mood)
                            )
                        } label: {
                            HStack(spacing: 18) {
                                Image(systemName: mood.symbol)
                                    .font(.system(size: 29))
                                    .foregroundStyle(.white)

                                VStack(
                                    alignment: .leading,
                                    spacing: 8
                                ) {
                                    Text(mood.title)
                                        .font(
                                            .system(
                                                size: 22,
                                                weight: .semibold
                                            )
                                        )
                                        .foregroundStyle(.white)

                                    Text(mood.subtitle)
                                        .font(.system(size: 16))
                                        .foregroundStyle(
                                            .white.opacity(0.65)
                                        )
                                        .lineLimit(2)
                                        .fixedSize(
                                            horizontal: false,
                                            vertical: true
                                        )
                                }
                            }
                            .padding(.horizontal, 22)
                            .padding(.vertical, 25)
                            .frame(
                                width: 300,
                                alignment: .leading
                            )
                            .frame(minHeight: 105)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.card)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
            }
            .scrollIndicators(.hidden)
        }
    }

    // MARK: - Movie Rows

   
    // MARK: - Movie Rows

    private func movieSection(
        title: String,
        subtitle: String,
        movies: [Movie]
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeading(
                title,
                subtitle: subtitle
            )

            if movies.isEmpty {
                Text("More stories coming soon.")
                    .font(.system(size: 18))
                    .foregroundStyle(.white.opacity(0.55))
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 34) {
                        ForEach(movies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                MovieCardView(movie: movie)
                            }
                            .buttonStyle(.card)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 35)
                }
                .scrollIndicators(.hidden)
                .overlay(alignment: .trailing) {
                    HStack {
                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(
                                .system(
                                    size: 30,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(.white.opacity(0.65))
                            .padding(.trailing, 10)
                            .frame(
                                width: 72,
                                height: 120
                            )
                            .background {
                                LinearGradient(
                                    colors: [
                                        .black.opacity(0),
                                        .black.opacity(0.75)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            }
                            .allowsHitTesting(false)
                    }
                }
            }
        }
    }


    // MARK: - Shared Section Heading

    private func sectionHeading(
        _ title: String,
        subtitle: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(title)
                .font(.system(size: 31, weight: .bold))
                .tracking(-0.6)
                .foregroundStyle(.white)

            Text(subtitle)
                .font(.system(size: 19))
                .foregroundStyle(.white.opacity(0.62))
        }
    }
}

// MARK: - Mood Movie Screen

private struct MoodMoviesView: View {
    let mood: Mood
    let movies: [Movie]

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            if movies.isEmpty {
                Text("More stories coming soon.")
                    .font(.system(size: 20))
                    .foregroundStyle(.white.opacity(0.65))
            } else {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 34) {
                        ForEach(movies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                MovieCardView(movie: movie)
                            }
                            .buttonStyle(.card)
                        }
                    }
                    .padding(.horizontal, 64)
                    .padding(.vertical, 50)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle(mood.title)
    }
}

// MARK: - Looping Video Background

private struct LoopingVideoBackground: UIViewRepresentable {
    let player: AVQueuePlayer

    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(
        _ uiView: PlayerView,
        context: Context
    ) {
        uiView.playerLayer.player = player
    }
}

private final class PlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
}

#Preview {
    HomeView()
}
