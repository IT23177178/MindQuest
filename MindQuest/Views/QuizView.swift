
import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    let currentQuestions: [QuizQuestion]

    private var currentQuestion: QuizQuestion {
        currentQuestions[viewModel.questionIndex]
    }

    var body: some View {
        VStack(spacing: 18) {
            // Top bar
            HStack {
                Button {
                    viewModel.screen = .home
                    viewModel.hasAnswered = true
                } label: {
                    Label("Exit game", systemImage: "chevron.left")
                        .foregroundStyle(AppTheme.forestGreen)
                }
                .buttonStyle(.plain)

                Spacer()

                Text(
                    viewModel.survivalMode
                    ? "SURVIVAL ROUND"
                    : viewModel.selectedCategory.rawValue.uppercased()
                )
                .font(.system(size: 13, weight: .bold))
                .tracking(2)
                .foregroundStyle(AppTheme.oliveGreen)

                Spacer()

                Text("SCORE  \(viewModel.score)")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.forestGreen)
            }

            // Question progress
            HStack(spacing: 10) {
                ForEach(0..<currentQuestions.count, id: \.self) { index in
                    Capsule()
                        .fill(
                            index < viewModel.questionIndex
                            ? AppTheme.oliveGreen
                            : index == viewModel.questionIndex
                                ? AppTheme.gold
                                : AppTheme.lightOlive
                        )
                        .frame(height: 6)
                }
            }

            HStack {
                Text(
                    "QUESTION \(viewModel.questionIndex + 1) OF \(currentQuestions.count)"
                )
                .font(.system(size: 13, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(AppTheme.textSecondary)

                Spacer()

                Label(
                    "Streak \(viewModel.streak)",
                    systemImage: "flame.fill"
                )
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppTheme.warning)
            }

            // Question panel
            Text(currentQuestion.question)
                .font(.system(size: 29, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(AppTheme.forestGreen)
                .frame(maxWidth: 900)
                .frame(maxHeight: .infinity)
                .padding(24)
                .background(
                    AppTheme.cardBackground,
                    in: RoundedRectangle(cornerRadius: 22)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .strokeBorder(
                            AppTheme.gold.opacity(0.55),
                            lineWidth: 1.5
                        )
                }

            // Answer choices
            HStack(spacing: 14) {
                ForEach(currentQuestion.answers.indices, id: \.self) { index in
                    answerButton(index)
                }
            }
            .frame(height: 100)

            // Timer
            HStack(spacing: 10) {
                Image(systemName: "clock.fill")

                Text("\(viewModel.remainingTime)s remaining")
                    .monospacedDigit()
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(
                viewModel.remainingTime <= 5
                ? AppTheme.error
                : AppTheme.textSecondary
            )

            // Answer feedback
            if viewModel.hasAnswered {
                VStack(spacing: 8) {
                    Text(feedbackTitle)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(feedbackColor)

                    Text(
                        viewModel.timeExpired
                        && viewModel.selectedAnswer == nil
                        ? "Time ran out. \(currentQuestion.explanation)"
                        : currentQuestion.explanation
                    )
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)

                    Button {
                        viewModel.advanceQuestion(
                            questionCount: currentQuestions.count
                        )
                    } label: {
                        Label(
                            viewModel.questionIndex + 1 == currentQuestions.count
                                ? "View Results"
                                : "Next Question",
                            systemImage: "arrow.right"
                        )
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(AppTheme.cardBackground)
                        .frame(minWidth: 200, minHeight: 58)
                        .background(
                            AppTheme.forestGreen,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                    }
                    .buttonStyle(.card)
                }
                .padding(.top, 2)
            }
        }
        .padding(.horizontal, 65)
        .padding(.vertical, 20)
        .background(AppTheme.background)
        .animation(
            .easeInOut(duration: 0.2),
            value: viewModel.hasAnswered
        )
    }

    private func answerButton(_ index: Int) -> some View {
        let isCorrect = index == currentQuestion.correctAnswer
        let isSelected = viewModel.selectedAnswer == index

        let fillColor: Color = {
            guard viewModel.hasAnswered else {
                return AppTheme.cardBackground
            }

            if isCorrect {
                return AppTheme.success.opacity(0.13)
            }

            if isSelected {
                return AppTheme.error.opacity(0.12)
            }

            return AppTheme.cardBackground
        }()

        let borderColor: Color = {
            guard viewModel.hasAnswered else {
                return AppTheme.oliveGreen.opacity(0.30)
            }

            if isCorrect {
                return AppTheme.success
            }

            if isSelected {
                return AppTheme.error
            }

            return AppTheme.oliveGreen.opacity(0.20)
        }()

        return Button {
            viewModel.selectAnswer(
                index,
                correctAnswer: currentQuestion.correctAnswer
            )
        } label: {
            VStack(spacing: 9) {
                Text(["A", "B", "C", "D"][index])
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(AppTheme.warning)

                Text(currentQuestion.answers[index])
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppTheme.textPrimary)
                    .lineLimit(3)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(fillColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(borderColor, lineWidth: 1.5)
                    }
            }
        }
        .buttonStyle(.card)
        .disabled(viewModel.hasAnswered)
    }

    private var feedbackTitle: String {
        if viewModel.timeExpired && viewModel.selectedAnswer == nil {
            return "Time's up!"
        }

        return viewModel.selectedAnswer == currentQuestion.correctAnswer
            ? "Correct! +100 points"
            : "Not quite!"
    }

    private var feedbackColor: Color {
        viewModel.selectedAnswer == currentQuestion.correctAnswer
            ? AppTheme.success
            : AppTheme.warning
    }
}
