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

    var futureDateMessage: String {
        return futureDate(price: goal.price, savingAmount: goal.savePerFrequency, savingFrequency: goal.frequency)
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

    func futureDate(price: Int, savingAmount: Int, savingFrequency: Frequency) -> String {
        let daysToAdd = price / savingAmount
        let today = Date()
        if let futureDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: today) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            let formattedDate = dateFormatter.string(from: futureDate)
            let weeks = daysToAdd / 7
            return "już za \(weeks) tygodni (\(formattedDate))"
        } else {
            return "Invalid date calculation"
        }
    }
}
