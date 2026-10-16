
import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: QuizViewModel
    let currentQuestions: [QuizQuestion]

    var body: some View {
        VStack(spacing: 22) {
            Image(
                systemName: viewModel.score >= currentQuestions.count * 100 / 2
                ? "trophy.fill"
                : "sparkles"
            )
            .font(.system(size: 70, weight: .regular))
            .foregroundStyle(AppTheme.gold)

            Text("Quest complete!")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(AppTheme.forestGreen)

            Text(
                viewModel.survivalMode
                ? "SURVIVAL ROUND"
                : viewModel.selectedCategory.rawValue.uppercased()
            )
            .font(.system(size: 14, weight: .bold))
            .tracking(3)
            .foregroundStyle(AppTheme.oliveGreen)

            HStack(spacing: 35) {
                resultStat(
                    value: "\(viewModel.score)",
                    label: "SCORE",
                    symbol: "star.fill"
                )

                resultStat(
                    value: "\(viewModel.score / 100)",
                    label: "CORRECT",
                    symbol: "checkmark.circle.fill"
                )

                resultStat(
                    value: "\(viewModel.bestStreak)",
                    label: "BEST STREAK",
                    symbol: "flame.fill"
                )
            }
            .padding(.vertical, 10)

            // XP earned and current level
            VStack(spacing: 6) {
                Text("LEVEL \(viewModel.playerLevel) · \(viewModel.playerTitle)")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.forestGreen)

                Text("\(viewModel.totalXP) total XP")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(AppTheme.textSecondary)

                Text(resultMessage)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
            }

            HStack(spacing: 18) {
                Button {
                    viewModel.startGame(
                        category: viewModel.selectedCategory,
                        survival: viewModel.survivalMode
                    )
                } label: {
                    Label("Play Again", systemImage: "arrow.clockwise")
                        .font(.system(size: 17, weight: .bold))
                        .frame(minWidth: 180)
                }
                .buttonStyle(.borderedProminent)
                .tint(AppTheme.forestGreen)
                .foregroundStyle(.white)

                Button {
                    viewModel.screen = .home
                } label: {
                    Label("Home", systemImage: "house.fill")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(minWidth: 140)
                }
                .buttonStyle(.bordered)
                .tint(AppTheme.forestGreen)
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.background)
    }

    private func resultStat(
        value: String,
        label: String,
        symbol: String
    ) -> some View {
        VStack(spacing: 9) {
            Image(systemName: symbol)
                .font(.system(size: 24))
                .foregroundStyle(AppTheme.gold)

            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(AppTheme.forestGreen)
                .monospacedDigit()

            Text(label)
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .frame(minWidth: 115)
        .padding(14)
        .background(
            AppTheme.cardBackground,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }

    private var resultMessage: String {
        let correct = viewModel.score / 100

        if correct == currentQuestions.count {
            return "Perfect round! You're a true Knowledge Explorer."
        } else if correct >= currentQuestions.count / 2 {
            return "Great work! Every question helps you learn."
        } else {
            return "Keep exploring. Every adventure teaches you something."
        }
    }
}
