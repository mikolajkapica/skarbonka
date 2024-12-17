import SwiftUI
import SwiftData

@Model
class Goal {
    @Attribute(.unique) var id = UUID()
    var goalName: String
    var icon: String
    var productPrice: Int
    var currentSavings: Int
    var savingFrequency: Int
    var savingAmount: Int
    var targetDate: Date
    var currency: String = "zł"
    

    init(goalName: String, icon: String, productPrice: Int, currentSavings: Int, savingFrequency: Int, savingAmount: Int, targetDate: Date, currency: String) {
        self.id = UUID()
        self.goalName = goalName
        self.icon = icon
        self.productPrice = productPrice
        self.currentSavings = currentSavings
        self.savingFrequency = savingFrequency
        self.savingAmount = savingAmount
        self.targetDate = targetDate
        self.currency = currency
    }
    
}
