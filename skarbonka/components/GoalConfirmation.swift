import SwiftUI

struct GoalConfirmation: View {
    @Environment(\.modelContext) private var context
    let goal: Goal
    @State var navigateToDetail: Bool = false
    
    
    
    
    func futureDate(price: Int, savingAmount: Int, savingFrequency: Int) -> String {
        let daysToAdd = price / savingAmount
        
        let today = Date()
        // Add the specified number of days to the current date
        if let futureDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: today) {
            // Format the future date to show only the day and month
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"  // "dd" for day, "MMM" for abbreviated month
            let formattedDate = dateFormatter.string(from: futureDate)
            
            // Calculate the number of full weeks
            let weeks = daysToAdd / 7
            
            // Return the result as a string
            return "już za \(weeks) tygodni (\(formattedDate))"
        } else {
            // Handle the case where the date calculation fails
            return "Invalid date calculation"
        }
    }


    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "Cel")
            ScrollView {
                VStack {
                    let msg = [
                        "Oszczędzaj ", String(goal.savingAmount) + "zł",
                        " tygodniowo i ciesz się z zakupu Puzzle za 80zł",
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
                    
                    Text(futureDate(price: goal.productPrice, savingAmount: goal.savingAmount, savingFrequency: goal.savingFrequency))
                    
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
            GoalEnd()
        }
    }

}

#Preview {
    GoalConfirmation(
        goal:
            Goal(
                goalName: "New Laptop",
                icon: "laptopcomputer",
                productPrice: 999,
                currentSavings: 450,
                savingFrequency: 1,
                savingAmount: 25,
                targetDate: Calendar.current.date(
                    byAdding: .day, value: 60, to: Date())!,
                currency: "zł"
            )
    )
}
