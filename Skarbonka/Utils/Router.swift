import SwiftUI

enum Route: Hashable {
    case GoalForm
    case GoalConfirmation(goal: GoalModel)
    case GoalSummary
}

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()	
    
    func removeAll() {
        path = NavigationPath()
    }

    func navigateTo(to route: Route) {
        path.append(route)
    }
}
