import SwiftUI
import SwiftData


class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    private let modelContext: ModelContext
    private var viewModels: [Route: Any] = [:]
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func navigate(to route: Route) {
        if viewModels[route] == nil {
            viewModels[route] = createViewModel(for: route)
        }
        path.append(route)
    }

    func goBack() {
        path.removeLast()
    }

    func goHome() {
        path.removeLast(path.count)
    }

    func getViewModel<T>(for route: Route) -> T? {
        return viewModels[route] as? T
    }

    private func createViewModel(for route: Route) -> Any? {
        switch route {
        case .goalConfirmation(let goal):
            return GoalConfirmationViewModel(goal: goal, modelContext: modelContext)
        default:
            return nil
        }
    }
}

