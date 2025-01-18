import SwiftUI
class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
}
