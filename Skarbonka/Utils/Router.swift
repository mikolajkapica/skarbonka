import SwiftUI
import SwiftData

// MARK: - Router
class Router: ObservableObject {
    // MARK: - Published Properties
    @Published var path: NavigationPath = NavigationPath()
    
    // MARK: - Private Properties
    private let modelContext: ModelContext
    private var viewModels: [Route: Any] = [:]
    
    // MARK: - Initialization
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

// MARK: - Navigation Methods
extension Router {
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
}

// MARK: - ViewModel Management
extension Router {
    func getViewModel<T>(for route: Route) -> T? {
        viewModels[route] as? T
    }
    
    private func createViewModel(for route: Route) -> Any? {
        switch route {
        case .goalConfirmation(let goal):
            return GoalConfirmationViewModel(
                goal: goal,
                modelContext: modelContext
            )
        default:
            return nil
        }
    }
}

