import SwiftUI

class GoalFormViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var goal: GoalModel
    @Published var isGoalCompleted: Bool
    @Published var selectedOption: String
    
    // MARK: - Validation Properties
    @Published var goalNameError: String?
    @Published var goalPriceError: String?
    @Published var currentSavingsError: String?
    
    // MARK: - Constants
    let icons: [String] = [
        "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
    ]
    
    // MARK: - Initialization
    init() {
        self.goal = GoalModel()
        self.isGoalCompleted = false
        self.selectedOption = "Codziennie"
        self.goal.icon = icons.first!
    }
}

// MARK: - Public Methods
extension GoalFormViewModel {
    var savePerFrequencyBinding: Binding<Double> {
        Binding(
            get: { Double(self.goal.savePerFrequency) },
            set: { self.goal.savePerFrequency = Int($0) }
        )
    }
    
    var frequencyBinding: Binding<String> {
        Binding(
            get: { 
                switch self.goal.frequency {
                case .daily: return "Codziennie"
                case .weekly: return "Co tydzień"
                case .monthly: return "Co miesiąc"
                }
            },
            set: { newValue in
                switch newValue {
                case "Codziennie": self.goal.frequency = .daily
                case "Co tydzień": self.goal.frequency = .weekly
                case "Co miesiąc": self.goal.frequency = .monthly
                default: break
                }
            }
        )
    }
    
    func calculateDays(_ goal: GoalModel) -> Int {
        let remainingAmount = max(0, Double(goal.price - goal.saved))
        let savePerFrequency = max(1, Double(goal.savePerFrequency))
        let saveFrequency = goal.frequency == .daily ? 1 : goal.frequency == .weekly ? 7 : 30
        return Int(ceil(remainingAmount / savePerFrequency) * Double(saveFrequency))
    }
    
    func isGoalValid(name: String, price: String, savings: String) -> Bool {
        guard let intPrice = Int(price),
              let intSavings = Int(savings) else { return false }
        
        return validateGoalName(name) &&
               validateGoalPrice(intPrice) &&
               validateCurrentSavings(intSavings) &&
               validateSavingsNotExceedPrice(savings: intSavings, price: intPrice)
    }
}

// MARK: - Update Methods
extension GoalFormViewModel {
    func updateGoalName(_ newValue: String) {
        goal.name = newValue
        goalNameError = validateGoalName(newValue) ? nil : "Nazwa celu nie może być pusta"
    }
    
    func updateGoalPrice(_ newValue: String) {
        guard let intValue = Int(newValue) else {
            goalPriceError = "Cena musi być liczbą"
            return
        }
        
        goal.price = intValue
        goalPriceError = validateGoalPrice(intValue) ? nil : "Cena musi być większa od 0"
    }
    
    func updateCurrentSavings(_ newValue: String) {
        guard let intValue = Int(newValue) else {
            currentSavingsError = "Oszczędności muszą być liczbą"
            return
        }
        
        goal.saved = intValue
        currentSavingsError = validateCurrentSavings(intValue) ? nil : "Oszczędności nie mogą być ujemne"
    }
}

// MARK: - Validation Methods
private extension GoalFormViewModel {
    func validateGoalName(_ value: String) -> Bool {
        !value.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func validateGoalPrice(_ value: Int) -> Bool {
        value > 0
    }
    
    func validateCurrentSavings(_ value: Int) -> Bool {
        value >= 0
    }

    func validateSavingsNotExceedPrice(savings: Int, price: Int) -> Bool {
        savings <= price
    }
}

// MARK: - Preview Helpers
#if DEBUG
extension GoalFormViewModel {
    static func preview() -> GoalFormViewModel {
        let viewModel = GoalFormViewModel()
        viewModel.goal = .preview
        viewModel.selectedOption = "Codziennie"
        return viewModel
    }
    
    static func previewEmpty() -> GoalFormViewModel {
        GoalFormViewModel()
    }
}
#endif
