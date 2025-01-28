import SwiftData
import SwiftUI

struct HomeView: View {
    @Query var goals: [GoalModel]
    @Environment(\.modelContext) private var modelContext: ModelContext
    @EnvironmentObject var router: Router
    @EnvironmentObject var style: StyleConfig
    
    // MARK: - Subviews
    private var headerView: some View {
        Text(String(localized: "Twoje cele oszczędnościowe"))
            .font(style.typography.m)
            .bold()
            .foregroundColor(style.theme.foreground)
    }
    
    private var addGoalButton: some View {
        Button(action: {
            router.navigate(to: .goalForm)
        }) {
            Text(String(localized: "Dodaj nowy cel"))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FilledButton())
        .bold()
    }
    
    private var goalsList: some View {
        ForEach(goals, id: \.id) { goal in
            GoalSummaryWidget(
                viewModel: GoalSummaryViewModel(
                    goal: goal,
                    modelContext: modelContext
                )
            )
        }
    }
    
    // MARK: - Navigation Content
    @ViewBuilder
    private func navigationContent(for route: Route) -> some View {
        switch route {
        case .goalForm:
            GoalFormView()
        case .goalConfirmation(let goal):
            if let viewModel: GoalConfirmationViewModel = router.getViewModel(for: .goalConfirmation(goal: goal)) {
                GoalConfirmationView(viewModel: viewModel)
            }
        case .goalEnd(let goal):
            GoalEndView(goal: goal)
        default:
            EmptyView()
        }
    }

    // MARK: - Body
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(spacing: 20) {
                    headerView
                    addGoalButton
                    goalsList
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(style.theme.backgroundGradient)
            .topBarTitle(String(localized: "Oszczędzanie"))
            .navigationDestination(for: Route.self) { route in
                navigationContent(for: route)
            }
        }
        .safeAreaInset(edge: VerticalEdge.bottom) {
            LionHelper()
        }
    }
}

// MARK: - Preview
#Preview {
    let container = DataController.previewContainer
    
    HomeView()
        .modelContainer(container)
        .environmentObject(Router(modelContext: container.mainContext))
        .environmentObject(StyleConfig())
}
