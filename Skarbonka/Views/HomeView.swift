import SwiftData
import SwiftUI

struct HomeView: View {
    @Query var goals: [GoalModel]
    @EnvironmentObject var router: Router
    @EnvironmentObject var style: StyleConfig

    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(spacing: 20) {
                    Text(String(localized: "Twoje cele oszczędnościowe"))
                        .font(style.typography.m)
                        .foregroundColor(style.theme.foreground)
                    NavigationLink(destination: GoalCreateView()) {
                        Text(String(localized: "Dodaj nowy cel"))
                    }
                    .buttonStyle(FilledButton())
                    ForEach(goals, id: \.id) { goal in
                        GoalSummaryWidget(goal: goal)
                    }
                }
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(style.theme.backgroundGradient)
            .topBarTitle(String(localized: "Oszczędzanie"))
        }
    }
}
