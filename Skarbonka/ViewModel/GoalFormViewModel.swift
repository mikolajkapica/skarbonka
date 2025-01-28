import SwiftUI

class GoalFormViewModel: ObservableObject {
    @Published var goal: GoalModel
    @Published var isGoalCompleted: Bool
    @Published var icons: [String]
    @Published var selectedOption: String
    @Published var goalNameError: String?
    @Published var goalPriceError: String?
    @Published var currentSavingsError: String?

    init() {
        self.goal = GoalModel()
        self.isGoalCompleted = false
        self.icons = [
            "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
        ]
        self.selectedOption = "Codziennie"
        self.goal.icon = icons.first!
    }

    func validateGoalName() {
        DispatchQueue.main.async {
            self.goalNameError =
                self.goal.name.isEmpty ? "Goal name cannot be empty" : nil
        }
    }

    func validateGoalPrice() {
        DispatchQueue.main.async {
            self.goalPriceError =
                self.goal.price <= 0 ? "Price must be greater than zero" : nil
        }
    }

    func validateCurrentSavings() {
        DispatchQueue.main.async {

            self.currentSavingsError =
                self.goal.saved < 0 ? "Savings cannot be negative" : nil
        }
    }

    func isGoalValid() -> Bool {
        validateGoalName()
        validateGoalPrice()
        validateCurrentSavings()
        return goalNameError == nil && goalPriceError == nil
            && currentSavingsError == nil
    }

    func updateGoalPrice(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.price = intValue
            validateGoalPrice()
        }
    }

    func updateCurrentSavings(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.saved = intValue
            validateCurrentSavings()
        }
    }
}
