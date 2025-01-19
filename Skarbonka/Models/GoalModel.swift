import SwiftData
import SwiftUI

enum Frequency: String, Codable {
    case daily, weekly, monthly
    
    func toString() -> String {
        switch self {
        case .daily: String(localized: "dziennie")
        case .weekly: String(localized: "tygodniowo")
        case .monthly: String(localized: "miesiecznie")
        }
    }
}

@Model
class GoalModel {
    @Attribute(.unique) var id = UUID()
    var name: String
    var icon: String
    var price: Int
    var frequency: Frequency
    var savePerFrequency: Int
    var start: Date
    var saved: Int
    
    init() {
        self.id = UUID()
        self.name = ""
        self.icon = ""
        self.price = 0
        self.frequency = Frequency.daily
        self.savePerFrequency = 20
        self.start = Date()
        self.saved = 0
    }
    
    init(id: UUID = UUID(), name: String, icon: String, price: Int, frequency: Frequency, savePerFrequency: Int, start: Date, saved: Int) {
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
