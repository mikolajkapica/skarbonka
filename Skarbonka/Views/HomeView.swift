import SwiftData
import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @Query var goals: [GoalModel]
    @Environment(\.modelContext) private var modelContext: ModelContext
    @EnvironmentObject var router: Router
    @EnvironmentObject var style: StyleConfig
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(spacing: 20) {
                    headerView
                    addGoalButton
                    if goals.isEmpty {
                        noGoalsView
                    } else {
                        goalsList
                    }
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(style.theme.backgroundGradient)
            .topBarTitle(String(localized: "Oszczędzanie"))
            .navigationDestination(for: Route.self) { route in
                navigationContent(for: route)
            }
            .lionMessage(String(localized: "Naciśnij przycisk aby dodać nowy cel oszczędnościowy"))
        }
        .safeAreaInset(edge: VerticalEdge.bottom) {
            LionHelper()
        }
    }
}

// MARK: - Components
private extension HomeView {
    var headerView: some View {
        Text(String(localized: "Twoje cele oszczędnościowe"))
            .font(style.typography.m)
            .bold()
            .foregroundColor(style.theme.foreground)
    }
    
    var addGoalButton: some View {
        Button(action: {
            router.navigate(to: .goalForm)
        }) {
            Text(String(localized: "Dodaj nowy cel"))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FilledButton())
        .bold()
        .accessibilityIdentifier("addNewGoalButton")
    }
    
    var goalsList: some View {
        ForEach(goals, id: \.id) { goal in
            GoalSummaryWidget(
                viewModel: GoalSummaryViewModel(
                    goal: goal,
                    modelContext: modelContext
                )
            )
        }
    }
    
    var noGoalsView: some View {
        Text("Nie masz jeszcze żadnych celów")
            .font(style.typography.m)
            .foregroundColor(style.theme.foreground)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 40)
    }
}

// MARK: - Navigation
private extension HomeView {
    @ViewBuilder
    func navigationContent(for route: Route) -> some View {
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
}

// MARK: - Preview
#if DEBUG
#Preview {
    HomeView()
        .modelContainer(DataController.previewContainer)
        .environmentObject(Router.preview())
        .environmentObject(StyleConfig.preview)
}
#endif
