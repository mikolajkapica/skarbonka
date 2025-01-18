import SwiftData
import SwiftUI

enum Tab {
    case home
    case games
    case profile
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
        TopBar()
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text(String(localized: "Oszczędzanie"))
                    }
                    .tag(Tab.home)
//                GamesView()
//                    .tabItem {
//                        Image(systemName: "play")
//                        Text(String("Gry"))
//                    }
//                    .tag(Tab.games)
//
//                ProfileView()
//                    .tabItem {
//                        Image(systemName: "person")
//                        Text(String("Profil"))
//                    }
//                    .tag(Tab.profile)
            }
//            LionHelper()
        }
    }
}

#Preview {
    let container = DataController.previewContainer
     
    ContentView()
        .modelContainer(container)
        .environmentObject(Router())
        .environmentObject(StyleConfig())
}
