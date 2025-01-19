import SwiftData
import SwiftUI

struct HomeView: View {
    @Query var goals: [GoalModel]
    @Environment(\.modelContext) private var modelContext: ModelContext
    @EnvironmentObject var router: Router
    @EnvironmentObject var style: StyleConfig

    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(spacing: 20) {
                    Text(String(localized: "Twoje cele oszczędnościowe"))
                        .font(style.typography.m)
                        .bold()
                        .foregroundColor(style.theme.foreground)
                    NavigationLink(
                        String(localized: "Dodaj nowy cel"),
                        value: "goalForm"
                    )
                    .navigationDestination(for: String.self) { _ in GoalFormView() }
                    .buttonStyle(FilledButton())
                    .bold()
                    ForEach(goals, id: \.id) { goal in
                        GoalSummaryWidget(viewModel: GoalSummaryViewModel(goal: goal, modelContext: modelContext))
                    }
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(style.theme.backgroundGradient)
            .topBarTitle(String(localized: "Oszczędzanie"))
        }
        .safeAreaInset(edge: VerticalEdge.bottom) {
            LionHelper()
        }
    }
}

#Preview {
    let container = DataController.previewContainer
     
    HomeView()
        .modelContainer(container)
        .environmentObject(Router())
        .environmentObject(StyleConfig())
}
