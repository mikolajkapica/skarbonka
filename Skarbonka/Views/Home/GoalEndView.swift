import SwiftUI

struct GoalEnd: View {
    let goal: GoalModel
    @EnvironmentObject private var style: StyleConfig

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    Text(String("Twój cel zotał dodany"))
                    Image(systemName: "puzzlepiece")
                        .foregroundColor( style.theme.background
                        )
                        .font(.system(size: 80))
                        .frame(width: 170, height: 170)
                        .background(style.theme.foreground)
                        .clipShape(Circle())
                    
                    Text(String("Puzzle"))
                    Text(String("80zł"))
                    Text(String("Oszczędzasz 5 zł dziennie"))
                    
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
    }

}

#Preview {
    GoalEnd(goal: generateRandomGoal())
        .environmentObject(StyleConfig())
}
