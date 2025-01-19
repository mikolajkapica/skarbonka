import SwiftUI

func generateRandomGoal() -> GoalModel {
    let names = ["Buy a New Laptop", "Save for Vacation", "Emergency Fund", "Buy a New Phone", "Retirement Savings"]
    let icons = ["laptopcomputer", "airplane", "briefcase", "phone", "banknote"]
    let frequencies: [Frequency] = [.daily, .weekly, .monthly]
    
    let randomName = names.randomElement()!
    let randomIcon = icons.randomElement()!
    let randomPrice = Int.random(in: 20...300)
    let randomFrequency = frequencies.randomElement()!
    let randomSavePerFrequency = Int.random(in: 1...50)
    let randomStartDate = Date()
    let randomSaved = Int.random(in: 0...randomPrice)
    
    return GoalModel(
        name: randomName,
        icon: randomIcon,
        price: randomPrice,
        frequency: randomFrequency,
        savePerFrequency: randomSavePerFrequency,
        start: randomStartDate,
        saved: randomSaved
    )
}
