import SwiftData
import SwiftUI

struct HomeView: View {
    // TODO: fetch from SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query var goals: [Goal]

    var body: some View {
        NavigationStack {
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
