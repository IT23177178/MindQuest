
import SwiftUI
import Combine

@MainActor
final class QuizViewModel: ObservableObject {

    @Published var screen: GameScreen = .home
    @Published var selectedCategory: QuizCategory = .space
    @Published var survivalMode = false

    @Published var questionIndex = 0
    @Published var score = 0
    @Published var streak = 0
    @Published var bestStreak = 0
    @Published var remainingTime = 15

    @Published var selectedAnswer: Int? = nil
    @Published var hasAnswered = false
    @Published var timeExpired = false

    // Persistent player progress
    @Published private(set) var totalXP: Int = UserDefaults.standard.integer(
        forKey: "mindQuestTotalXP"
    )

    private var hasAwardedRoundXP = false

    private let levelThresholds = [0, 200, 500, 1_000]

    var playerLevel: Int {
        if totalXP >= 1_000 { return 4 }
        if totalXP >= 500 { return 3 }
        if totalXP >= 200 { return 2 }
        return 1
    }

    var playerTitle: String {
        switch playerLevel {
        case 1: return "Explorer"
        case 2: return "Trailblazer"
        case 3: return "Adventurer"
        default: return "Knowledge Keeper"
        }
    }

    var levelProgress: Double {
        guard playerLevel < levelThresholds.count else {
            return 1.0
        }

        let currentThreshold = levelThresholds[playerLevel - 1]
        let nextThreshold = levelThresholds[playerLevel]
        let progress = totalXP - currentThreshold
        let levelRange = nextThreshold - currentThreshold

        return min(max(Double(progress) / Double(levelRange), 0), 1)
    }

    var xpToNextLevel: Int {
        guard playerLevel < levelThresholds.count else {
            return 0
        }

        return max(
            0,
            levelThresholds[playerLevel] - totalXP
        )
    }

    func startGame(category: QuizCategory, survival: Bool) {
        selectedCategory = category
        survivalMode = survival

        questionIndex = 0
        score = 0
        streak = 0
        bestStreak = 0

        remainingTime = survival ? 10 : 15

        selectedAnswer = nil
        hasAnswered = false
        timeExpired = false
        hasAwardedRoundXP = false

        screen = .quiz
    }

    func selectAnswer(_ index: Int, correctAnswer: Int) {
        guard !hasAnswered else { return }

        selectedAnswer = index
        hasAnswered = true

        if index == correctAnswer {
            score += 100
            streak += 1
            bestStreak = max(bestStreak, streak)

            addXP(10)
        } else {
            streak = 0
        }
    }

    func handleTimeout() {
        guard !hasAnswered else { return }

        timeExpired = true
        hasAnswered = true
        streak = 0
    }

    func advanceQuestion(questionCount: Int) {
        if questionIndex + 1 < questionCount {
            questionIndex += 1
            selectedAnswer = nil
            hasAnswered = false
            timeExpired = false
            remainingTime = survivalMode ? 10 : 15
        } else {
            if !hasAwardedRoundXP {
                addXP(25)
                hasAwardedRoundXP = true
            }

            hasAnswered = true
            screen = .results
        }
    }

    private func addXP(_ amount: Int) {
        totalXP += amount
        UserDefaults.standard.set(
            totalXP,
            forKey: "mindQuestTotalXP"
        )
    }
}
