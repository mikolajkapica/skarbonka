import SwiftData
import SwiftUI

// MARK: - Frequency Enum
enum Frequency: String, Codable {
    case daily
    case weekly
    case monthly
}

// MARK: - Frequency Localization
extension Frequency {
    func toString() -> String {
        switch self {
        case .daily:
            String(localized: "dziennie")
        case .weekly:
            String(localized: "tygodniowo")
        case .monthly:
            String(localized: "miesiecznie")
        }
    }
}

// MARK: - Goal Model
@Model
class GoalModel {
    // MARK: - Properties
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var price: Int
    var frequency: Frequency
    var savePerFrequency: Int
    var start: Date
    var saved: Int
    
    // MARK: - Computed Properties
    var progress: Float {
        Float(saved) / Float(price)
    }
    
    var remainingAmount: Int {
        price - saved
    }
    
    // MARK: - Initialization
    init() {
        self.id = UUID()
        self.name = ""
        self.icon = ""
        self.price = 0
        self.frequency = .daily
        self.savePerFrequency = 20
        self.start = Date()
        self.saved = 0
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        icon: String,
        price: Int,
        frequency: Frequency,
        savePerFrequency: Int,
        start: Date,
        saved: Int
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.price = price
        self.frequency = frequency
        self.savePerFrequency = savePerFrequency
        self.start = start
        self.saved = saved
    }
}

// MARK: - Goal Model Helpers
extension GoalModel {
    func calculateDaysToComplete() -> Int {
        let remainingAmount = Double(price - saved)
        let saveFrequency = Double(savePerFrequency)
        return Int(ceil(remainingAmount / saveFrequency))
    }
    
    func isCompleted() -> Bool {
        saved >= price
    }
    
    func getAmountToSave() -> Int {
        min(remainingAmount, savePerFrequency)
    }
}

// MARK: - Preview Helpers
#if DEBUG
extension GoalModel {
    static var preview: GoalModel {
        GoalModel(
            name: "Sample Goal",
            icon: "star",
            price: 1000,
            frequency: .daily,
            savePerFrequency: 20,
            start: Date(),
            saved: 200
        )
    }
    
    static var previewCompleted: GoalModel {
        GoalModel(
            name: "Completed Goal",
            icon: "checkmark.circle",
            price: 1000,
            frequency: .weekly,
            savePerFrequency: 100,
            start: Date(),
            saved: 1000
        )
    }
    
    static var previewEmpty: GoalModel {
        GoalModel(
            name: "New Goal",
            icon: "plus.circle",
            price: 500,
            frequency: .monthly,
            savePerFrequency: 50,
            start: Date(),
            saved: 0
        )
    }
}
#endif
