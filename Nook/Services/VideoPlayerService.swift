
import AVKit
import Observation
import Foundation

@MainActor
@Observable
final class VideoPlayerService {

    private(set) var player: AVPlayer?
    private(set) var savedPosition: Double = 0

    private let progressKey = "Nook.SnowBear.playbackPosition"

    @ObservationIgnored
    private var timeObserverToken: Any?

    var hasSavedProgress: Bool {
        savedPosition > 5
    }

    func loadVideo(named fileName: String) -> Bool {
        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: "mp4"
        ) else {
            return false
        }

        removeTimeObserver()
        player?.pause()

        let newPlayer = AVPlayer(url: url)
        newPlayer.actionAtItemEnd = .pause
        player = newPlayer

        savedPosition = UserDefaults.standard.double(
            forKey: progressKey
        )

        // Do not seek yet. Let the viewer choose whether to resume
        // or start from the beginning.

        addTimeObserver(to: newPlayer)
        return true
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
        saveCurrentPosition()
    }

    func resumeFromSavedPosition(
        completion: @MainActor @escaping () -> Void
    ) {
        guard let player else {
            completion()
            return
        }

        let time = CMTime(
            seconds: savedPosition,
            preferredTimescale: 600
        )

        player.seek(
            to: time,
            toleranceBefore: .zero,
            toleranceAfter: .zero
        ) { _ in
            Task { @MainActor in
                completion()
            }
        }
    }

    func startFromBeginning() {
        savedPosition = 0
        UserDefaults.standard.set(0, forKey: progressKey)

        player?.seek(to: .zero)
    }

    func saveCurrentPosition() {
        guard let player else { return }

        let seconds = player.currentTime().seconds

        guard seconds.isFinite, seconds >= 0 else { return }

        savedPosition = seconds
        UserDefaults.standard.set(seconds, forKey: progressKey)
    }

    func stop() {
        saveCurrentPosition()
        player?.pause()
        removeTimeObserver()
        player?.replaceCurrentItem(with: nil)
        player = nil
    }

    private func addTimeObserver(to player: AVPlayer) {
        let interval = CMTime(
            seconds: 2,
            preferredTimescale: 600
        )

        timeObserverToken = player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            guard let self, time.seconds.isFinite else { return }

            self.savedPosition = time.seconds
            UserDefaults.standard.set(
                time.seconds,
                forKey: self.progressKey
            )
        }
    }

    private func removeTimeObserver() {
        if let timeObserverToken, let player {
            player.removeTimeObserver(timeObserverToken)
        }

        timeObserverToken = nil
    }
}
