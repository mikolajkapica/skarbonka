import SwiftUI

struct GoalEnd: View {
    let goal: Goal
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    Text(String("Twój cel zotał dodany"))
                    
                    
                    Image(systemName: "puzzlepiece")
                        .foregroundColor(
                            SkarbonkaColors.black
                        )
                        .font(.system(size: 80))
                        .frame(width: 170, height: 170)
                        .background(SkarbonkaColors.white)
                        .clipShape(Circle())
                    
                    Text(String("Puzzle"))
                    Text(String("80zł"))
                    Text(String("Oszczędzasz 5 zł dziennie"))
                    
                }
                .foregroundStyle(.white)
                .font(SkarbonkaTextSize.m.fontSize)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                
                VStack(spacing: 16) {
                    NavigationLink(
                        destination: HomeView().navigationBarBackButtonHidden(true)
                    ) {
                        Text("Wróć")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(SkarbonkaColors.Orange)
                            .cornerRadius(.infinity)

                        
                    }
                }
            }
            .padding(24)
        }
        .background(SkarbonkaColors.PurpleGradient)
    }

}

#Preview {
    GoalEnd(goal: mockGoal)
}
