import SwiftUI

enum Tab {
    case home
    case search
    case profile
}


struct ContentView: View {

    var body: some View {
        Navigation()
    }
}

struct Navigation: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(Tab.home)

                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(Tab.search)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(Tab.profile)
            }
        }
        .fontDesign(.rounded)
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
        .background(Color.white)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
