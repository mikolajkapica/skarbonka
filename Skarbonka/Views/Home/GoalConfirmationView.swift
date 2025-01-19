import SwiftUI

struct GoalConfirmation: View {
    @StateObject var viewModel: GoalConfirmationViewModel
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var style: StyleConfig
    
    var goalMessage: some View {
        let msg = [
            "Oszczędzaj ",
            String(viewModel.goal.savePerFrequency) + "zł",
            " tygodniowo i ciesz się z zakupu \(viewModel.goal.name) za \(viewModel.goal.price) \(String(localized: "zl"))",
        ]
        return
            (Text(msg[0])
            + Text(msg[1]).foregroundStyle(style.theme.primary)
            + Text(msg[2]))
            .frame(maxWidth: CGFloat(290))
    }

    var iconView: some View {
        Image(systemName: viewModel.goal.icon)
            .foregroundColor(style.theme.background)
            .font(.system(size: 80))
            .frame(width: 170, height: 170)
            .background(style.theme.foreground)
            .clipShape(Circle())
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    goalMessage
                    iconView
                    Text(viewModel.futureDateMessage ?? String(localized: "Nie udalo sie obliczyc daty"))
                }
                .foregroundStyle(.white)
                .font(style.typography.m)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)

                VStack(spacing: 16) {
                    Button(action: viewModel.saveGoal) {
                        Text("Zapisz cel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(style.theme.primary)
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
                            .background(style.theme.foreground)
                            .cornerRadius(.infinity)
                    }
                }
            }
            .padding(24)
        }
        .background(style.theme.backgroundGradient)
        .navigationDestination(isPresented: $viewModel.navigateToDetail) {
            GoalEnd(goal: viewModel.goal)
        }
        .navigationBarBackButtonHidden(true)
    }
}
