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
    var body: some View {
        VStack{
            VStack {
                VStack {
                    Text(goal.goalName)
                    Text("\(goal.productPrice) zł")
                }
                .bold()
                GoalIcon(progress: Float(goal.currentSavings) / Float(goal.productPrice))
                VStack {
                    Text(String(localized: "Brawo"))
                    HStack {
                        Text(String(localized: "Masz już"))
                        Text("\(goal.currentSavings) \(goal.currency)").bold().foregroundColor(SkarbonkaColors.Orange)
                    }
                }
            }
            .padding(20)

            VStack {
                Image("piggy_bank").foregroundColor(SkarbonkaColors.Orange.mix(with: .white, by: 0.2))
                HStack {
                    Text(String(localized: "Odłóż dziś"))
                    Text("\(goal.productPrice) \(goal.currency) ").foregroundColor(SkarbonkaColors.Orange)
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


#Preview {
    GoalSummary(
        goal: Goal(
           goalName: "Bilet do EnergyLandii",
           icon: "puzzlepiece",
           productPrice: 129,
           currentSavings: 77,
           savingFrequency: "Co tydzień",
           savingAmount: 11.0,
           targetDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!,
           currency: "zł"
       )
    )
    
}
