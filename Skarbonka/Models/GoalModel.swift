import SwiftData
import SwiftUI

enum Frequency: String, Codable {
    case daily
    case weekly
    case monthly
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
    var saved: Int = 0
    
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

struct GoalDTO: Hashable {
    var name: String?
    var icon: String?
    var price: Int?
    var frequency: Frequency?
    var savePerFrequency: Int?
    var start: Date?
    var saved: Int?
}

extension GoalDTO {
    func toModel() -> GoalModel? {
        guard let name = name,
            let icon = icon,
            let price = price,
            let frequency = frequency,
            let savePerFrequency = savePerFrequency,
            let start = start
        else {
            return nil
        }

        return GoalModel(
            name: name,
            icon: icon,
            price: price,
            frequency: frequency,
            savePerFrequency: savePerFrequency,
            start: start,
            saved: saved ?? 0
        )
    }
}
