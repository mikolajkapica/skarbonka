import SwiftUI

enum Tab {
    case home
    case search
    case profile
    case test
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var selectedTab: Tab = .home

    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text(String(localized: "Oszczędzanie"))
                    }
                    .tag(Tab.home)

                GamesView()
                    .tabItem {
                        Image(systemName: "play")
                        Text(String("Gry"))
                    }
                    .tag(Tab.search)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text(String("Profil"))
                    }
                    .tag(Tab.profile)
            }
            
            LionHelper()

        }
    }
}

struct NavigationPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

