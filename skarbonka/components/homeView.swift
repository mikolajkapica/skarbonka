import SwiftUI

struct HomeView: View {
    // TODO: fetch from SwiftData
    var goals = [
        Goal(
            goalName: "New Laptop",
            selectedIcon: "laptopcomputer",
            productPrice: 999,
            currentSavings: 450,
            savingFrequency: "Bi-weekly",
            savingAmount: 25.0,
            targetDate: Calendar.current.date(byAdding: .day, value: 60, to: Date())!,
            currency: "zł",
            icon: "cat"
        ),
        Goal(
           goalName: "Bilet do EnergyLandii",
           selectedIcon: "puzzlepiece",
           productPrice: 129,
           currentSavings: 77,
           savingFrequency: "Co tydzień",
           savingAmount: 11.0,
           targetDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!,
           currency: "zł",
           icon: "cat"
       ),
    ]
        
        var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TopBar(title: "Oszczęności", isBack: false)
                ScrollView {
                    VStack(spacing: 20) {
                        Text(String(localized: "Twoje cele oszczędnościowe"))
                            .font(SkarbonkaTextSize.m.fontSize.bold())
                            .foregroundColor(.white)
                        NavigationLink(
                            String(localized: "Dodaj nowy cel"),
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
