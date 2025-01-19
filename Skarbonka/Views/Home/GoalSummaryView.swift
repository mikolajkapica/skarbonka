import SwiftData
import SwiftUI

struct GoalSummaryWidget: View {
    @ObservedObject var viewModel: GoalSummaryViewModel
    @EnvironmentObject private var style: StyleConfig

    private var goalProgress: some View {
        VStack {
            Group {
                Text(viewModel.goal.name)
                Text("\(viewModel.goal.price) \(String(localized: "zl"))")
            }
            .bold()
            GoalProgress(
                progress: viewModel.progress,
                icon: viewModel.goal.icon
            )
            Text(String(localized: "Brawo!"))
                .multilineTextAlignment(.center)
            
            HStack {
                Text(String(localized: "Masz już"))
                Text("\(viewModel.goal.saved) \(String(localized: "zl"))")
                    .foregroundColor(style.theme.primary)
                    .bold()
            }
        }
        .padding(24)
    }

    private var goalAction: some View {
        VStack {
            Image("piggy-active")
                .foregroundColor(style.theme.primary)
            
            if viewModel.isCompleted() {
                Text(String(localized: "Brawo! Udao sie zebrac!")).bold()
                Button(action: viewModel.removeGoal) {
                    Text(String(localized: "Usuń cel"))
                        .bold()
                }
                .buttonStyle(FilledButton())
            } else {
                HStack {
                    Text(String(localized: "Odłóż dziś"))
                    Text("\(viewModel.getAmountToSave()) \(String(localized: "zl"))")
                        .foregroundColor(style.theme.primary)
                }
                .bold()
                Button(action: viewModel.addMoneyToGoal) {
                    Text(String(localized: "Zrobione")).bold()
                }
                .buttonStyle(FilledButton())
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(Color.white.opacity(0.2))
    }

    var body: some View {
        VStack {
            goalProgress
            goalAction
        }
        .font(style.typography.m)
        .foregroundColor(.white)
        .background(.white.opacity(0.1))
        .cornerRadius(24)
    }
}

#Preview {
    let style = StyleConfig()
    let container = DataController.previewContainer
    let goal = generateRandomGoal()
    let viewModel = GoalSummaryViewModel(goal: goal, modelContext: ModelContext(container))
    GoalSummaryWidget(viewModel: viewModel)
        .environmentObject(style)
        .background(style.theme.backgroundGradient)
}
