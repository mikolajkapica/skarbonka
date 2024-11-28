import SwiftUI

enum Tab {
    case home
    case search
    case profile
    case test
}


struct ContentView: View {

    var body: some View {
        Navigation()
    }
}

struct Navigation: View {
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


struct TopBar: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title).font(.largeTitle)
            Spacer()
            Image(systemName: "bell")
        }
        .padding(16)
        .contentMargins(0)
        .background(Color.white)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
