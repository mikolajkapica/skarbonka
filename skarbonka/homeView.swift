import SwiftUI


struct HomeView: View {
    @State private var goalView: Bool = false
    var body: some View {
        NavigationView {
            
            VStack(spacing: 0) {
                TopBar(title: "Savings")
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(String(localized: "Your savings goals")).withSize(.xxl)
                        NavigationLink(String(localized: "Add new goal"), destination: ProfileView()
                        )
                        .buttonStyle(SkarbonkaButtonStyle(style: .filled))
                        goal()
                        goal()
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                .background(Color.purple.gradient)
            }
        }
    }
    
    struct NewGoal: View {
        @State private var goalName: String = ""
        var body: some View {
            VStack {
                TextField("your goal?", text: $goalName)
            }
        }
    }
}


struct goal: View {
    var body: some View {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Bilet do energylandii").withSize(.xl)
                            Text("80 z 130 zł").withSize(.l)
                        }
                        Spacer()
                        GoalIcon()
                    }
                
                    Text(String(localized:"Add to skarbonka")) .withSize(.s)
                
                    HStack {
                        Text("10 zł 💰")
                        Text("za 3 tyg. 📅")
                    }
                
                    NavigationLink(destination: ProfileView()) {
                        HStack {
                            Image(systemName: "creditcard")
                            Text(String(localized: "Odkładam pieniądze"))
                        }
                    }
                    .style(.filled)
                    .padding(.bottom)
                    .padding(.top)

                    
                    NavigationLink(destination: ProfileView()) {
                        HStack {
                            Image(systemName: "arrow.right")
                            Text(String("See more"))

                        }
                    }
                    .style(.border)
                }
                .padding()
                .background(
                    Rectangle()
                        .cornerRadius(32)
                        .foregroundColor(.blue) // Background color of the rectangle
                )
                .foregroundColor(.white)
        }

}



struct GoalIcon: View {
    let progress: CGFloat = 90
    let size: CGFloat = 100
    let lineWidth: CGFloat = 6
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: progress / 360)
                .stroke(Color.orange, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
        }
        .overlay(
            Image(systemName: "ticket")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .frame(width: size - lineWidth / 2, height: size - lineWidth / 2)
                .background(Color.gray.mix(with: Color.orange, by: 0.3))
                .clipShape(Circle())
        )
        .frame(width: size, height: size)
    }
}
