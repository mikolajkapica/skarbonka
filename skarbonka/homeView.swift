import SwiftUI


struct goal: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.gradient).opacity(0.2)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Bilet do energylandii")
                            .font(Custom.headline)
                        Text("80 z 130 zł")
                            .font(Custom.subheadline)
                    }
                    Spacer()
                    Image(systemName: "ticket")
                        .font(Custom.subheadline)
                }
                Text(String(localized:"addToSkarbonka"))
                HStack {
                    Text("10 zł 💰")
                    Text("za 3 tyg. 📅")
                }
                Button(action: {}){
                    Text("Odkładam pieniądze")
                }

            }
            .padding()
            .foregroundColor(.white)

        }
        .frame(height: 300)
        .padding()
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
            goal()
            Spacer()
        }
        .background(Color.purple.gradient)
    }
}
