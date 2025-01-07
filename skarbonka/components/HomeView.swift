import SwiftData
import SwiftUI

struct HomeView: View {
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
                            destination: GoalCreateView()
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
}

#Preview {
    HomeView()
}

