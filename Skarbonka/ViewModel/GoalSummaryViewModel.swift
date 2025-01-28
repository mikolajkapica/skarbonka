import SwiftUI
import Combine
import SwiftData

class GoalSummaryViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var goal: GoalModel
    @Published var progress: Float
    
    // MARK: - Private Properties
    private var modelContext: ModelContext
    
    // MARK: - Initialization
    init(goal: GoalModel, modelContext: ModelContext) {
        self.goal = goal
        self.modelContext = modelContext
        self.progress = Self.calculateProgress(saved: goal.saved, price: goal.price)
    }
}

// MARK: - Public Methods
extension GoalSummaryViewModel {
    func getAmountToSave() -> Int {
        let amountLeftToSave = goal.price - goal.saved
        return min(amountLeftToSave, goal.savePerFrequency)
    }
    
    func addMoneyToGoal() {
        goal.saved += getAmountToSave()
        updateProgress()
    }
    
    func isCompleted() -> Bool {
        getAmountToSave() == 0
    }
    
    func removeGoal() {
        modelContext.delete(goal)
    }
}

// MARK: - Private Methods
private extension GoalSummaryViewModel {
    func updateProgress() {
        progress = Self.calculateProgress(saved: goal.saved, price: goal.price)
    }
    
    static func calculateProgress(saved: Int, price: Int) -> Float {
        Float(saved) / Float(price)
    }
}

// MARK: - Preview Helpers
#Preview {
    let goal = generateRandomGoal()
    let modelContext = ModelContext()
    return GoalSummaryViewModel(goal: goal, modelContext: modelContext)
}
