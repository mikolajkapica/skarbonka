import SwiftUI

struct GoalSummaryWidget: View {
    @EnvironmentObject private var style: StyleConfig
    var goal: GoalModel

    var body: some View {
        VStack {
            VStack {
                Group {
                    Text(goal.name)
                    Text("\(goal.price) \(String(localized: "zl"))")
                }
                .bold()
                GoalIcon(
                    progress: Float(goal.saved) / Float(goal.price),
                    icon: goal.icon
                )
                VStack {
                    Text(
                        String(localized: "Brawo!")
                    )
                    .multilineTextAlignment(.center)
                    HStack {
                        Text(String(localized: "Masz już"))
                        Text("\(goal.saved) \(String(localized: "zl"))")
                            .foregroundColor(style.theme.primary)
                            .bold()
                    }
                }
            }
            .padding(24)

            VStack {
                Image("piggy_bank")
                    .foregroundColor(style.theme.primary)
                HStack {
                    Text(String(localized: "Odłóż dziś"))
                    Text("\(goal.savePerFrequency) \(String(localized: "zl"))")
                        .foregroundColor(style.theme.primary)
                }
                .bold()
                Button(action: {
                    // TODO: Add money to a goal
                }) {
                    Text(String(localized: "Zrobione"))
                        .bold()
                }
                .buttonStyle(FilledButton())
            }
            .frame(maxWidth: .infinity)
            .padding(24)
            .background(Color.white.opacity(0.2))
        }
        .font(style.typography.m)
        .foregroundColor(.white)
        .background(.white.opacity(0.1))
        .cornerRadius(24)
        .padding(24)
    }
}

#Preview {
    let style = StyleConfig()
    GoalSummaryWidget(goal: generateRandomGoal())
        .environmentObject(style)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(style.theme.backgroundGradient)
}
