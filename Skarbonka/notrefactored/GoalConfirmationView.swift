import SwiftUI

struct GoalConfirmation: View {
    let goal: Goal

    @Environment(\.modelContext) private var context

    @State var navigateToDetail: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    let msg = [
                        "Oszczędzaj ", String(goal.savingAmount) + "zł",
                        " tygodniowo i ciesz się z zakupu \(goal.goalName) za \(goal.productPrice) \(goal.currency)",
                    ]

                    (Text(msg[0])
                        + Text(msg[1]).foregroundStyle(
                            SkarbonkaColors.Orange)
                        + Text(msg[2])).frame(maxWidth: CGFloat(290))

                    Image(systemName: goal.icon)
                        .foregroundColor(
                            SkarbonkaColors.black
                        )
                        .font(.system(size: 80))
                        .frame(width: 170, height: 170)
                        .background(SkarbonkaColors.white)
                        .clipShape(Circle())

                    Text(
                        futureDate(
                            price: goal.productPrice,
                            savingAmount: goal.savingAmount,
                            savingFrequency: goal.savingFrequency))

                }
                .foregroundStyle(.white)
                .font(SkarbonkaTextSize.m.fontSize)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)

                VStack(spacing: 16) {
                    Button(action: {
                        print("fsdiogjsd")
                        context.insert(goal)
                        do {
                            try context.save()
                        } catch {
                            print("error")
                        }
                        navigateToDetail.toggle()
                    }) {
                        Text("Zapisz cel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(SkarbonkaColors.Orange)
                            .cornerRadius(.infinity)
                    }

                    Button(action: {
                        print("Saving goal updated")
                    }) {
                        Text("Anuluj")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(SkarbonkaColors.white)
                            .cornerRadius(.infinity)
                    }
                }
            }
            .padding(24)
        }
        .background(SkarbonkaColors.PurpleGradient)
        .navigationDestination(isPresented: $navigateToDetail) {
            GoalEnd(goal: goal)
        }
    }

    func futureDate(price: Int, savingAmount: Int, savingFrequency: Int)
        -> String
    {
        let daysToAdd = price / savingAmount
        let today = Date()
        if let futureDate = Calendar.current.date(
            byAdding: .day, value: daysToAdd, to: today)
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            let formattedDate = dateFormatter.string(from: futureDate)
            let weeks = daysToAdd / 7
            return "już za \(weeks) tygodni (\(formattedDate))"
        } else {
            return "Invalid date calculation"
        }
    }

}

#Preview {
    GoalConfirmation(goal: mockGoal)
}
