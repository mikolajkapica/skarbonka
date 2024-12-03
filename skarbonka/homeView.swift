import SwiftUI

struct HomeView: View {
    @State private var goalView: Bool = false
    var goals = [
        Goal(
           goalName: "Bilet do EnergyLandii",
           selectedIcon: "puzzlepiece",
           productPrice: "129",
           currentSavings: "77",
           savingFrequency: "Co tydzień",
           savingAmount: 11.0,
           targetDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!
       ),
       Goal(
           goalName: "Bilet do EnergyLandii",
           selectedIcon: "puzzlepiece",
           productPrice: "129",
           currentSavings: "77",
           savingFrequency: "Co tydzień",
           savingAmount: 11.0,
           targetDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!
       ),
       Goal(
           goalName: "Bilet do EnergyLandii",
           selectedIcon: "puzzlepiece",
           productPrice: "129",
           currentSavings: "77",
           savingFrequency: "Co tydzień",
           savingAmount: 11.0,
           targetDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!
       )
    ]
        
        var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TopBar(title: "Savings", isBack: false)
                ScrollView {
                    VStack(spacing: 20) {
                        Text(String(localized: "Your savings goals"))
                            .font(SkarbonkaTextSize.m.fontSize.bold())
                            .foregroundColor(.white)
                        NavigationLink(
                            String(localized: "Add new goal"),
                            destination: GoalView()
                        )
                        .buttonStyle(SkarbonkaButtonStyle(style: .filled))
                        ForEach(goals, id: \.goalName) { goal in
                            GoalSummary(goal: goal)
                        }
                    }
                    .padding(24)
                }
                .background(SkarbonkaColors.PurpleGradient)
            }
        }
    }

    struct NewGoal: View {
        @State private var goalName: String = ""
        var body: some View {
            VStack {
                TextField("your goal?", text: $goalName)
            }
        }
    }
}
