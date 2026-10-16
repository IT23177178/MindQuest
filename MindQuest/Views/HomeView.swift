
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            // Welcome
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .foregroundStyle(AppTheme.gold)

                        Text("MINDQUEST")
                            .font(.system(size: 15, weight: .bold))
                            .tracking(5)
                            .foregroundStyle(AppTheme.oliveGreen)
                    }

                    Text("Ready for an adventure?")
                        .font(.system(size: 37, weight: .bold))
                        .tracking(-1)
                        .foregroundStyle(AppTheme.forestGreen)

                    Text("Explore new worlds. Discover amazing things!")
                        .font(.system(size: 17))
                        .foregroundStyle(AppTheme.textSecondary)
                }

                Spacer()

                Image(systemName: "tree.fill")
                    .font(.system(size: 58))
                    .foregroundStyle(AppTheme.oliveGreen)
                    .padding(.trailing, 8)
            }

            // Player progress
            HStack(spacing: 16) {
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(AppTheme.gold)

                VStack(alignment: .leading, spacing: 5) {
                    Text("LEVEL \(viewModel.playerLevel) · \(viewModel.playerTitle.uppercased())")
                        .font(.system(size: 13, weight: .bold))
                        .tracking(1)
                        .foregroundStyle(AppTheme.forestGreen)

                    Text("\(viewModel.totalXP) XP earned")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppTheme.textSecondary)

                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(AppTheme.lightOlive)

                            Capsule()
                                .fill(AppTheme.gold)
                                .frame(
                                    width: geometry.size.width
                                        * viewModel.levelProgress
                                )
                        }
                    }
                    .frame(height: 8)
                }

                Text("\(viewModel.xpToNextLevel) XP to next level")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.textSecondary)
                    .frame(width: 130, alignment: .trailing)
            }
            .padding(15)
            .background(
                AppTheme.cardBackground,
                in: RoundedRectangle(cornerRadius: 18)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(AppTheme.gold.opacity(0.55), lineWidth: 1)
            }

            // Categories
            HStack {
                Text("CHOOSE YOUR WORLD")
                    .font(.system(size: 14, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(AppTheme.forestGreen)

                Spacer()

                Text("4 WORLDS · 20 QUESTIONS")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppTheme.oliveGreen)
            }

            HStack(spacing: 16) {
                ForEach(QuizCategory.allCases) { category in
                    categoryCard(category)
                }
            }

            // Game modes
            HStack(spacing: 18) {
                Button {
                    viewModel.startGame(
                        category: viewModel.selectedCategory,
                        survival: false
                    )
                } label: {
                    Label("Start Adventure", systemImage: "play.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(AppTheme.cardBackground)
                        .frame(minWidth: 230, minHeight: 58)
                        .background(
                            AppTheme.forestGreen,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                }
                .buttonStyle(.card)

                Button {
                    viewModel.startGame(
                        category: viewModel.selectedCategory,
                        survival: true
                    )
                } label: {
                    Label("Survival Challenge", systemImage: "flame.fill")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(AppTheme.forestGreen)
                        .frame(minWidth: 220, minHeight: 58)
                        .background(
                            AppTheme.lightGold,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                }
                .buttonStyle(.card)
            }

        }
        .padding(.horizontal, 65)
        .padding(.vertical, 24)
    }

    private func categoryCard(
        _ category: QuizCategory
    ) -> some View {
        let isSelected = viewModel.selectedCategory == category

        return Button {
            viewModel.selectedCategory = category
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: category.symbol)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(category.color)

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 21))
                            .foregroundStyle(AppTheme.oliveGreen)
                    }
                }

                Spacer(minLength: 4)

                Text(category.rawValue)
                    .font(.system(size: 21, weight: .bold))
                    .foregroundStyle(AppTheme.forestGreen)

                Text(category.subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(AppTheme.textSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 105)
            .padding(16)
            .background {
                RoundedRectangle(
                    cornerRadius: AppTheme.cardCornerRadius
                )
                .fill(
                    isSelected
                    ? AppTheme.lightGold.opacity(0.75)
                    : AppTheme.cardBackground
                )
                .overlay {
                    RoundedRectangle(
                        cornerRadius: AppTheme.cardCornerRadius
                    )
                    .strokeBorder(
                        isSelected
                        ? AppTheme.gold
                        : AppTheme.oliveGreen.opacity(0.25),
                        lineWidth: isSelected ? 2.5 : 1
                    )
                }
            }
        }
        .buttonStyle(.card)
        .accessibilityLabel(
            "\(category.rawValue), \(category.subtitle)"
        )
    }
}

#Preview {
    HomeView(viewModel: QuizViewModel())
}
