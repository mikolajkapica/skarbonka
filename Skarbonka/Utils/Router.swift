import SwiftUI
import SwiftData


class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    private var viewModels: [Route: Any] = [:]
    
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
        case .goalForm:
            return GoalFormViewModel()
        case .goalConfirmation(let goal):
            return GoalConfirmationViewModel(context: modelContext, goal: goal)
        default:
            return nil
        }
    }
}

