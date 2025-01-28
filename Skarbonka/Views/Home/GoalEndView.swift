import SwiftUI
import SwiftData

struct GoalEndView: View {
    let goal: GoalModel
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router

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
                    Button(action: {
                        router.goHome()
                    }) {
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
    let container = DataController.previewContainer
    return GoalEndView(goal: generateRandomGoal())
        .modelContainer(container)
        .environmentObject(Router(modelContext: container.mainContext))
        .environmentObject(StyleConfig())
}
