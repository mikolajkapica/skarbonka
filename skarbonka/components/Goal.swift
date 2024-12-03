import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect, byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct GoalSummary: View {
    var goal: Goal
    var amountPaidAlready = 77
    var amountToSave = 11
    var currency = "zł"
    var body: some View {
        VStack{
            VStack {
                VStack {
                    Text("Bilet do energylandii")
                    Text("129 zł")
                }
                .bold()
                GoalIcon()
                VStack {
                    Text(String(localized: "Brawo"))
                    HStack {
                        Text(String(localized: "Masz już"))
                        Text("\(amountPaidAlready) \(currency)").bold().foregroundColor(SkarbonkaColors.Orange)
                    }
                }
            }
            .padding(20)

            VStack {
                Image(systemName: "creditcard").foregroundColor(SkarbonkaColors.Orange.mix(with: .white, by: 0.2))
                HStack {
                    Text(String(localized: "Odłóż dziś"))
                    Text("\(amountToSave) \(currency) ").foregroundColor(SkarbonkaColors.Orange)
                }
                .bold()


                NavigationLink(destination: ProfileView()) {
                    Text(String(localized: "Zrobione"))
                }
                .style(.border)
            }
            .padding(20)
            .background(Color.white.opacity(0.2))
            .roundedCorner(24, corners: [.bottomLeft, .bottomRight])
        }
        .font(SkarbonkaTextSize.m.fontSize)
        .background(.white.opacity(0.1))
        .cornerRadius(24)
        .foregroundColor(.white)
    }
}

struct GoalIcon: View {
    let progress: CGFloat = 230
    let size: CGFloat = 150
    let lineWidth: CGFloat = 10
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: progress / 360)
                .stroke(SkarbonkaColors.Orange, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
        }
        .overlay(
            Image(systemName: "ticket")
                .foregroundColor(SkarbonkaColors.black)
                .font(.system(size: 64))
                .frame(
                    width: size - lineWidth / 2, height: size - lineWidth / 2
                )
                .background(SkarbonkaColors.white)
                .clipShape(Circle())
        )
        .frame(width: size, height: size)
    }
}

#Preview {
    GoalSummary(
        goal: Goal(
           goalName: "Bilet do EnergyLandii",
           selectedIcon: "puzzlepiece",
           productPrice: "129",
           currentSavings: "77",
           savingFrequency: "Co tydzień",
           savingAmount: 11.0,
           targetDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!
       )
    )
    
}
