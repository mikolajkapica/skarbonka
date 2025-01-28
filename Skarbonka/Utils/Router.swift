import SwiftUI
class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()	
    
    func removeAll() {
        path = NavigationPath()
    }
}
