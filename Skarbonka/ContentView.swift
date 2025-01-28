import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var selection: Tabs = .home
    @EnvironmentObject private var style: StyleConfig
    
    init() {
        TabBarConfigurator.configure()
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
}

#Preview {
    let container = DataController.previewContainer
    ContentView()
        .modelContainer(container)
        .environmentObject(Router(modelContext: container.mainContext))
        .environmentObject(StyleConfig())
}
