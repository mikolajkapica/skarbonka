import SwiftUI

enum Tab {
    case home
    case search
    case profile
}


struct ContentView: View {
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

struct HomeView: View {
    var body: some View {
        VStack {
            TopBar(title: "Home")
            Text("Twoje cele oszczędnościowe")
            Button(action:  {}) {
                Text("Dodaj nowy cel")
            }
            block()
        }
        
    }
}

struct block: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.indigo.gradient)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Bilet do energylandii")
                        Text("80 z 130 zł")
                        
                    }
                    Spacer()
                    Image(systemName: "ticket")
                }
                Text("Dodaj do skarbonki:")
                HStack {
                    Text("10 zł 💰")
                    Text("za 3 tyg. 📅")
                }
                Button(action: {}){
                    Text("Odkładam pieniądze")
                }

            }
            .foregroundColor(.white)

        }
        .padding()
        .fontWeight(.bold)
    }

}
    

struct SearchView: View {
    var body: some View {
        VStack {
            TopBar(title: "Search")
            Spacer()
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            TopBar(title: "Profile")
            Spacer()
        }
    }
}

struct TopBar: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "bell")
        }
        .padding(16)
        .background(Color.white)
        .shadow(radius: 1)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
