import SwiftUI
import Combine

class GoalSummaryViewModel: ObservableObject {
    @Published var goal: GoalModel
    @Published var progress: Float
    @Published var savedAmountText: String
    @Published var savePerFrequencyText: String
    
    private var style: StyleConfig

    init(goal: GoalModel, style: StyleConfig) {
        self.goal = goal
        self.style = style
        self.progress = Float(goal.saved) / Float(goal.price)
        self.savedAmountText = "\(goal.saved) \(String(localized: "zl"))"
        self.savePerFrequencyText = "\(goal.savePerFrequency) \(String(localized: "zl"))"
    }

    func addMoneyToGoal() {
        // Logic to add money to the goal goes here
    }
}
