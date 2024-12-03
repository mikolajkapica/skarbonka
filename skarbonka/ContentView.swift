import SwiftUI

enum Tab {
    case home
    case search
    case profile
    case test
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text(String(localized: "Savings"))
                }
                .tag(Tab.home)

            SearchView()
                .tabItem {
                    Image(systemName: "play")
                    Text(String("Games"))
                }
                .tag(Tab.search)

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text(String("Profile"))
                }
                .tag(Tab.profile)
        }
    }
}

struct NavigationPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

