import SwiftUI
import SwiftData

class GoalConfirmationViewModel: ObservableObject {
    @Published var navigateToDetail: Bool = false
    private var context: ModelContext
    var goal: GoalModel

    init(context: ModelContext, goal: GoalModel) {
        self.context = context
        self.goal = goal
    }

    var futureDateMessage: String? {
        var calculatedDays: Int {
            let remainingAmount = max(0, Double(goal.price - goal.saved))
            let saveFrequency = max(1, Double(goal.savePerFrequency))
            return Int(ceil(remainingAmount / saveFrequency))
        }
        let dateFormat = "dd MMM"
        let weekDays = 7
        let today = Date()
        if let futureDate = Calendar.current.date(byAdding: .day, value: calculatedDays, to: today) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            let formattedDate = dateFormatter.string(from: futureDate)
            let weeks = calculatedDays / weekDays
            return "\(String(localized: "już za")) \(weeks) \(String(localized: "tygodni")) (\(formattedDate))"
        }
        return nil
    }

    func saveGoal() {
        context.insert(goal)
        do {
            try context.save()
            navigateToDetail = true
        } catch {
            print("Error saving goal")
        }
    }
}
