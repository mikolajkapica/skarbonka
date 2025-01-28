import SwiftUI
import SwiftData

class GoalConfirmationViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var navigateToDetail: Bool = false
    
    // MARK: - Properties
    let goal: GoalModel
    private let context: ModelContext
    
    // MARK: - Initialization
    init(goal: GoalModel, modelContext: ModelContext) {
        self.goal = goal
        self.context = modelContext
    }
}

// MARK: - Public Methods
extension GoalConfirmationViewModel {
    var futureDateMessage: String? {
        guard let futureDate = calculateFutureDate() else { return nil }
        
        let formattedDate = formatDate(futureDate)
        let weeks = calculatedDays / 7
        
        return weeks == 0 
            ? "\(String(localized: "za")) \(calculatedDays) \(String(localized: "dni")) (\(formattedDate))"
            : "\(String(localized: "już za")) \(weeks) \(String(localized: "tygodni")) (\(formattedDate))"
    }
    
    func saveGoal() {
        context.insert(goal)
        do {
            try context.save()
        } catch {
            print("Error saving goal")
        }
    }
}

// MARK: - Private Methods
private extension GoalConfirmationViewModel {
    var calculatedDays: Int {
        let remainingAmount = max(0, Double(goal.price - goal.saved))
        let saveFrequency = max(1, Double(goal.savePerFrequency))
        return Int(ceil(remainingAmount / saveFrequency))
    }
    
    func calculateFutureDate() -> Date? {
        Calendar.current.date(
            byAdding: .day,
            value: calculatedDays,
            to: Date()
        )
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: date)
    }
}

// MARK: - Preview Helpers
#if DEBUG
extension GoalConfirmationViewModel {
    static func preview() -> GoalConfirmationViewModel {
        GoalConfirmationViewModel(
            goal: .preview,
            modelContext: ModelContext(DataController.previewContainer)
        )
    }
}
#endif
