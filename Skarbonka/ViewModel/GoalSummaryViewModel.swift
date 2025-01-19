import SwiftUI
import Combine
import SwiftData

class GoalSummaryViewModel: ObservableObject {
    @Published var goal: GoalModel
    @Published var progress: Float
    private var modelContext: ModelContext
    
    init(goal: GoalModel, modelContext: ModelContext) {
        self.goal = goal
        self.modelContext = modelContext
        self.progress = Float(goal.saved) / Float(goal.price)
    }

    func getAmountToSave() -> Int {
        let amountLeftToSave = goal.price - goal.saved
        return min(amountLeftToSave, goal.savePerFrequency)
    }

    func addMoneyToGoal() -> () {
        goal.saved += getAmountToSave()
    }
    
    func isCompleted() -> Bool {
        getAmountToSave() == 0
    }
    
    func removeGoal() -> () {
        modelContext.delete(goal)
    }
}
