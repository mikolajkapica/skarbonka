import SwiftUI

class GoalFormViewModel: ObservableObject {
    @Published var goal: GoalModel = GoalModel()
    @Published var selectedOption: String? = nil
    @Published var isGoalCompleted: Bool = false
    @Published var icons = [
        "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
    ]
    
    init() {
        goal = GoalModel()
        goal.icon = icons.first!
    }

    func updateGoalPrice(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.price = intValue
        }
    }

    func updateCurrentSavings(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.savePerFrequency = intValue
        }
    }

    func isGoalValid() -> Bool {
        return !goal.name.isEmpty
            && goal.price > 0
            && goal.saved >= 0
            && selectedOption != nil
            && goal.icon != ""
    }

}
