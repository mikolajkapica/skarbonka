import SwiftUI
import SwiftData

@Model
class Goal {
    @Attribute(.unique) var id = UUID()
    var goalName: String
    var selectedIcon: String?
    var productPrice: Int
    var currentSavings: Int
    var savingFrequency: String
    var savingAmount: Double
    var targetDate: Date
    var currency: String = "zł"
    

    init(goalName: String, selectedIcon: String? = Optional.none, productPrice: Int, currentSavings: Int, savingFrequency: String, savingAmount: Double, targetDate: Date, currency: String, icon: String) {
        self.id = UUID()
        self.goalName = goalName
        self.selectedIcon = selectedIcon
        self.productPrice = productPrice
        self.currentSavings = currentSavings
        self.savingFrequency = savingFrequency
        self.savingAmount = savingAmount
        self.targetDate = targetDate
        self.currency = currency
    }
    
}
