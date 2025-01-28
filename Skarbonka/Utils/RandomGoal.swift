import Foundation

// MARK: - Random Goal Generation
struct RandomGoalGenerator {
    // MARK: - Constants
    private static let names = [
        "Buy a New Laptop",
        "Save for Vacation",
        "Emergency Fund",
        "Buy a New Phone",
        "Retirement Savings"
    ]
    
    private static let icons = [
        "laptopcomputer",
        "airplane",
        "briefcase",
        "phone",
        "banknote"
    ]
    
    private static let frequencies: [Frequency] = [.daily, .weekly, .monthly]
    
    // MARK: - Generation
    static func generate() -> GoalModel {
        GoalModel(
            name: names.randomElement()!,
            icon: icons.randomElement()!,
            price: Int.random(in: 20...300),
            frequency: frequencies.randomElement()!,
            savePerFrequency: Int.random(in: 1...50),
            start: Date(),
            saved: Int.random(in: 0...300)
        )
    }
}

// MARK: - Global Helper
func generateRandomGoal() -> GoalModel {
    RandomGoalGenerator.generate()
}
