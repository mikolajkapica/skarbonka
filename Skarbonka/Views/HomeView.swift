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
                    Button(action: {
                        router.navigate(to: Route.goalForm)
                    }) {
                        Text(String(localized: "Dodaj nowy cel")).frame(
                            maxWidth: .infinity)
                    }
                    .buttonStyle(FilledButton())
                    .bold()
                    ForEach(goals, id: \.id) { goal in
                        GoalSummaryWidget(
                            viewModel: GoalSummaryViewModel(
                                goal: goal, modelContext: modelContext))
                    }
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(style.theme.backgroundGradient)
            .topBarTitle(String(localized: "Oszczędzanie"))
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .goalForm:
                    GoalFormView()
                case .goalConfirmation(let goal):
                    GoalConfirmationView(
                        viewModel: GoalConfirmationViewModel(
                            context: modelContext, goal: goal))

                case .goalEnd(let goal):
                    GoalEndView(goal: goal)
                default:
                    EmptyView()
                }
            }
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
