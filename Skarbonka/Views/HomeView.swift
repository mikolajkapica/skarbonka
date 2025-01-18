import SwiftData
import SwiftUI

struct HomeView: View {
    @Query var goals: [Goal]
    @ObservedObject var router = Router.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        Text(String(localized: "Twoje cele oszczędnościowe"))
                            .font(SkarbonkaTextSize.m.fontSize.bold())
                            .foregroundColor(.white)
                        NavigationLink(
                            String(localized: "Dodaj nowy cel"),
                            value: mockGoal
                        )
                        .navigationDestination(for: Goal.self, destination: { _ in GoalCreateView() })
//                        .buttonStyle(SkarbonkaButtonStyle(style: .filled))
                        ForEach(goals, id: \.goalName) { goal in
                            GoalSummary(goal: goal)
                        }
                    }
                    .padding(24)
                }
            }
            .frame(maxWidth: .infinity)
            .background(SkarbonkaColors.PurpleGradient)
            .topBarTitle("Gówne")
        }
    }
}

#Preview {
    HomeView()
}

