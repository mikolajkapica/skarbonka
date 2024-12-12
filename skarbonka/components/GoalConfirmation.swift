import SwiftUI

struct GoalConfirmation: View {
    @Environment(\.modelContext) private var context
    let goal: Goal
    @State var navigateToDetail: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "Cel")
            ScrollView {
                VStack {
                    let msg = [
                        "Oszczędzaj ", "5zł",
                        " tygodniowo i ciesz się z zakupu Puzzle za 80zł",
                    ]

                    (Text(msg[0])
                        + Text(msg[1]).foregroundStyle(
                            SkarbonkaColors.Orange)
                        + Text(msg[2])).frame(maxWidth: CGFloat(290))

                    Image(systemName: "puzzlepiece")
                        .foregroundColor(
                            SkarbonkaColors.black
                        )
                        .font(.system(size: 80))
                        .frame(width: 170, height: 170)
                        .background(SkarbonkaColors.white)
                        .clipShape(Circle())

                    Text("już za 16 tygodni (29 kwietnia)")
                }
                .foregroundStyle(.white)
                .font(SkarbonkaTextSize.m.fontSize)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)

                VStack(spacing: 16) {
                    Button(action: {
                        context.insert(goal)
                        try! context.save()
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
                savingFrequency: "Bi-weekly",
                savingAmount: 25.0,
                targetDate: Calendar.current.date(
                    byAdding: .day, value: 60, to: Date())!,
                currency: "zł"
            )
    )
}
