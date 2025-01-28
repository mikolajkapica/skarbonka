import SwiftData
import SwiftUI

enum Tabs {
    case home
    case games
    case profile
    
    var title: String {
        switch self {
        case .home: String(localized: "Oszczędzanie")
        case .games: String(localized: "Gry")
        case .profile: String(localized: "Profil")
        }
    }
    
    func icon(isSelected: Bool) -> String {
        switch self {
        case .home: isSelected ? "piggy-active" : "piggy"
        case .games: isSelected ? "play-active" : "play"
        case .profile: isSelected ? "profile-active" : "profile"
        }
    }
}

struct ContentView: View {
    @State private var selection: Tabs = .home
    @EnvironmentObject private var style: StyleConfig
    
    init() {
        configureTabBarAppearance()
    }
    
    var body: some View {
        TopBar()
        TabView(selection: $selection) {
            Tab(
                Tabs.home.title,
                image: Tabs.home.icon(isSelected: selection == Tabs.home),
                value: .home
            ) {
                HomeView()
            }
            Tab(
                Tabs.games.title,
                image: Tabs.games.icon(isSelected: selection == Tabs.games),
                value: .games
            ) {
                GamesView()
            }
            Tab(
                Tabs.profile.title,
                image: Tabs.profile.icon(isSelected: selection == Tabs.profile),
                value: .profile
            ) {
                ProfileView()
            }
        }
        .tint(style.theme.primary)
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    let container = DataController.previewContainer
    ContentView()
        .modelContainer(container)
        .environmentObject(Router(modelContext: container.mainContext))
        .environmentObject(StyleConfig())
}
