import SwiftUI
import SwiftData

struct GoalEndView: View {
    // MARK: - Properties
    let goal: GoalModel
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    successHeader
                    goalIcon
                    goalDetails
                }
                .foregroundStyle(.white)
                .font(style.typography.m)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                
                actionButton
            }
            .padding(24)
        }
        .background(style.theme.backgroundGradient)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Components
private extension GoalEndView {
    var successHeader: some View {
        Text(String(localized: "Twój cel zotał dodany"))
    }
    
    var goalIcon: some View {
        Image(systemName: goal.icon)
            .foregroundColor(style.theme.background)
            .font(.system(size: 80))
            .frame(width: 170, height: 170)
            .background(style.theme.foreground)
            .clipShape(Circle())
    }
    
    var goalDetails: some View {
        VStack {
            Text(goal.name)
            Text("\(goal.price) \(String(localized: "zl"))")
            Text(savingsDescription)
        }
    }
    
    var actionButton: some View {
        VStack(spacing: 16) {
            Button(action: router.goHome) {
                Text(String(localized: "Wróć"))
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(style.theme.primary)
                    .cornerRadius(.infinity)
            }
        }
    }
    
    var savingsDescription: String {
        String(
            localized: "\(String(localized: "Oszczędzasz")) \(goal.savePerFrequency) \(String(localized: "zl")) \(goal.frequency.toString())"
        )
    }
}

// MARK: - Preview
#Preview {
    let container = DataController.previewContainer
    return GoalEndView(goal: generateRandomGoal())
        .modelContainer(container)
        .environmentObject(Router(modelContext: container.mainContext))
        .environmentObject(StyleConfig())
}
