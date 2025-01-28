import SwiftData
import SwiftUI

struct GoalSummaryWidget: View {
    // MARK: - Properties
    @ObservedObject var viewModel: GoalSummaryViewModel
    @EnvironmentObject private var style: StyleConfig
    
    // MARK: - Body
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

// MARK: - Components
private extension GoalSummaryWidget {
    var goalProgress: some View {
        VStack {
            goalHeader
            GoalProgress(
                progress: viewModel.progress,
                icon: viewModel.goal.icon
            )
            congratsMessage
            savedAmountInfo
        }
        .padding(24)
    }
    
    var goalHeader: some View {
        Group {
            Text(viewModel.goal.name)
            Text("\(viewModel.goal.price) \(String(localized: "zl"))")
        }
        .bold()
    }
    
    var congratsMessage: some View {
        Text(String(localized: "Brawo!"))
            .multilineTextAlignment(.center)
    }
    
    var savedAmountInfo: some View {
        HStack {
            Text(String(localized: "Masz już"))
            Text("\(viewModel.goal.saved) \(String(localized: "zl"))")
                .foregroundColor(style.theme.primary)
                .bold()
        }
    }
    
    var goalAction: some View {
        VStack {
            Image("piggy-active")
                .foregroundColor(style.theme.primary)
            
            if viewModel.isCompleted() {
                completedGoalContent
            } else {
                activeGoalContent
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(Color.white.opacity(0.2))
    }
    
    var completedGoalContent: some View {
        VStack {
            Text(String(localized: "Brawo! Udao sie zebrac!")).bold()
            Button(action: viewModel.removeGoal) {
                Text(String(localized: "Usuń cel"))
                    .bold()
            }
            .buttonStyle(FilledButton())
        }
    }
    
    var activeGoalContent: some View {
        VStack {
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
}

// MARK: - Preview
#Preview {
    let container = DataController.previewContainer
    let goal = generateRandomGoal()
    let viewModel = GoalSummaryViewModel(
        goal: goal,
        modelContext: ModelContext(container)
    )
    
    return GoalSummaryWidget(viewModel: viewModel)
        .environmentObject(StyleConfig())
        .background(StyleConfig().theme.backgroundGradient)
}
