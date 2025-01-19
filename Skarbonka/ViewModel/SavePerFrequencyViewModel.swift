import SwiftUI

class SavePerFrequencyViewModel: ObservableObject {
    @Published var goal: GoalModel
    
    init(goal: GoalModel) {
        self.goal = goal
    }
    
    var calculatedDays: Int {
        let remainingAmount = max(0, Double(goal.price - goal.saved))
        let saveFrequency = max(1, Double(goal.savePerFrequency))
        return Int(ceil(remainingAmount / saveFrequency))
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    var savePerFrequencyBinding: Binding<Double> {
        Binding<Double>(
            get: { Double(self.goal.savePerFrequency) },
            set: { self.goal.savePerFrequency = Int($0) }
        )
    }
}
