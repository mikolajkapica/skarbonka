import SwiftUI

struct GoalEnd: View {
    let goal: GoalModel
    @EnvironmentObject private var style: StyleConfig

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    Text(String(localized: "Twój cel zotał dodany"))
                    Image(systemName: goal.icon)
                        .foregroundColor( style.theme.background
                        )
                        .font(.system(size: 80))
                        .frame(width: 170, height: 170)
                        .background(style.theme.foreground)
                        .clipShape(Circle())
                    
                    Text(goal.name)
                    Text("\(goal.price) \(String(localized: "zl"))")
                    Text("\(String(localized: "Oszczędzasz")) \(goal.savePerFrequency) \(String(localized: "zl")) \(goal.frequency.toString())")
                    
                }
                .foregroundStyle(.white)
                .font(style.typography.m)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                
                VStack(spacing: 16) {
                    NavigationLink(
                        destination: HomeView()
                    ) {
                        Text("Wróć")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(style.theme.primary)
                            .cornerRadius(.infinity)
                    }
                }
            }
            .padding(24)
        }
        .background(style.theme.backgroundGradient)
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    GoalEnd(goal: generateRandomGoal())
        .environmentObject(StyleConfig())
}
