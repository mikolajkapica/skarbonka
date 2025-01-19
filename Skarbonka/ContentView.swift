import SwiftData
import SwiftUI

enum Tab {
    case home
    case games
    case profile
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @EnvironmentObject private var style: StyleConfig

    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    let imagePadding: CGFloat = 40

    var body: some View {
        TopBar()
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Text(String(localized: "Oszczędzanie"))
                    Image(
                        selectedTab == Tab.home ? "piggy-active" : "piggy")
                }
                .tag(Tab.home)
            GamesView()
                .tabItem {
                    Image(selectedTab == Tab.games ? "play-active" : "play")
                    Text(String(localized: "Gry"))
                }
                .tag(Tab.games)
            ProfileView()
                .tabItem {
                    Image(
                        selectedTab == Tab.profile
                            ? "profile-active" : "profile"
                    )
                    Text(String(localized: "Profil"))
                }
                .tag(Tab.profile)
        }
        .tint(style.theme.primary)
    }

}

#Preview {
    let container = DataController.previewContainer

    ContentView()
        .modelContainer(container)
        .environmentObject(Router())
        .environmentObject(StyleConfig())
}
