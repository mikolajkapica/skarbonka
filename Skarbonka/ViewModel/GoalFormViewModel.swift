import SwiftUI

class GoalFormViewModel: ObservableObject {
    @Published var goal: GoalModel
    @Published var isGoalCompleted: Bool
    @Published var icons: [String]
    @Published var selectedOption: String

    init() {
        self.goal = GoalModel()
        self.isGoalCompleted = false
        self.icons = [
            "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
        ]
        self.selectedOption = "Codziennie"
        self.goal.icon = icons.first!
    }

    func updateGoalPrice(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.price = intValue
        }
    }

    func updateCurrentSavings(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.saved = intValue
        }
    }

    func isGoalValid() -> Bool {
        return !goal.name.isEmpty
            && goal.price > 0
            && goal.saved >= 0
            && goal.icon != ""
    }

}
