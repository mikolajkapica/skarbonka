import SwiftUI


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


struct goal: View {
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Bilet do energylandii").withSize(.xl)
                        Text("80 z 130 zł").withSize(.l)
                    }
                    Spacer()
                    GoalIcon()
                }
                Text(String(localized:"addToSkarbonka"))
                    .withSize(.s)
                HStack {
                    Text("10 zł 💰")
                    Text("za 3 tyg. 📅")
                }
                Button(action: {}){
                    Text(String(localized: "Odkładam pieniądze"))
                }
                .style()
                
                Button(action: {}){
                    Text("Zobacz więcej")
                }
                .style()
            }
            .padding()
            .background(
                Rectangle()
                    .cornerRadius(32)
                    .foregroundColor(.blue) // Background color of the rectangle
            )
            .padding()
            .foregroundColor(.white)
    }
}
struct HomeView: View {
    var body: some View {
        VStack {
            TopBar(title: "Oszczędności")
            ScrollView {
                Text("Twoje cele oszczędnościowe")
                    .withSize(.xxl)
                Button(action:  {}) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Dodaj nowy cel")
                    }
                }.style()
                goal()
                goal()
                Spacer()
            }
        }
        .background(Color.purple.gradient)
    }
}

#Preview {
    HomeView()
}
