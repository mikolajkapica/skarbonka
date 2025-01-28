import SwiftData
import SwiftUI

enum Tabs {
    case home
    case games
    case profile
}

struct ContentView: View {
    @State private var selection: Tabs = .home
    @EnvironmentObject private var style: StyleConfig

    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TopBar()
        TabView(selection: $selection) {
            Tab(
                String(localized: "Oszczędzanie"),
                image: selection == Tabs.home ? "piggy-active" : "piggy",
                value: .home
            ) {
                HomeView()
            }
            Tab(
                String(localized: "Gry"),
                image: selection == Tabs.games ? "play-active" : "play",
                value: .games
            ) {
                GamesView()
            }
            Tab(
                String(localized: "Profil"),
                image: selection == Tabs.profile ? "profile-active" : "profile",
                value: .profile
            ) {
                ProfileView()
            }
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
