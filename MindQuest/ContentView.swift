
import SwiftUI
import Combine

enum GameScreen {
    case home
    case quiz
    case results
}

struct ContentView: View {
    @StateObject private var viewModel = QuizViewModel()

    private var currentQuestions: [QuizQuestion] {
        QuestionBank.questions.filter {
            $0.category == viewModel.selectedCategory
        }
    }

    var body: some View {
        ZStack {
            AppTheme.background
                .ignoresSafeArea()

            RadialGradient(
                colors: [
                    AppTheme.lightOlive.opacity(0.75),
                    AppTheme.background.opacity(0.3),
                    AppTheme.background
                ],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 900
            )
            .ignoresSafeArea()

            Group {
                switch viewModel.screen {
                case .home:
                    HomeView(viewModel: viewModel)

                case .quiz:
                    QuizView(
                        viewModel: viewModel,
                        currentQuestions: currentQuestions
                    )

                case .results:
                    ResultsView(
                        viewModel: viewModel,
                        currentQuestions: currentQuestions
                    )
                }
            }
        }
        .foregroundStyle(AppTheme.textPrimary)
        .onReceive(
            Timer.publish(
                every: 1,
                on: .main,
                in: .common
            ).autoconnect()
        ) { _ in
            guard viewModel.screen == .quiz,
                  !viewModel.hasAnswered,
                  !viewModel.timeExpired else {
                return
            }

            if viewModel.remainingTime > 0 {
                viewModel.remainingTime -= 1
            }

            if viewModel.remainingTime == 0 {
                viewModel.handleTimeout()
            }
        }
    }
}

#Preview {
    ContentView()
}
