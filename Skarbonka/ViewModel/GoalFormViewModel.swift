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
    
    func updateGoalName(_ newValue: String) {
        goal.name = newValue
        if (!validateGoalName(newValue)) {
            goalNameError = "Nazwa celu nie może być pusta"
        } else {
            goalNameError = nil
        }
    }

    func updateGoalPrice(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.price = intValue
            if (!validateGoalPrice(intValue)) {
                goalPriceError = "Cena musi być większa od 0"
            } else {
                goalPriceError = nil
            }
        } else {
            goalPriceError = "Cena musi być liczbą"
        }
    }

    func updateCurrentSavings(_ newValue: String) {
        if let intValue = Int(newValue) {
            goal.saved = intValue
            if (!validateCurrentSavings(intValue)) {
                currentSavingsError = "Oszczędności nie mogą być ujemne"
            } else {
                currentSavingsError = nil
            }   
        } else {
            currentSavingsError = "Oszczędności muszą być liczbą"
        }
    }

    func validateGoalName(_ value: String) -> Bool {
        return !value.isEmpty
    }

    func validateGoalPrice(_ value: Int) -> Bool {
        return value > 0
    }

    func validateCurrentSavings(_ value: Int) -> Bool {
        return value >= 0
    }

    func isGoalValid(name: String, price: String, savings: String) -> Bool {
        if let intPrice = Int(price), let intSavings = Int(savings) {
            return validateGoalName(name) && validateGoalPrice(intPrice)
                && validateCurrentSavings(intSavings)
        }
        return false
    }
}
