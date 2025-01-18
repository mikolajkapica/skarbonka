import SwiftUI
import SwiftData

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: GoalModel.self, configurations: config)
            
            for i in 1...9 {
                let goal = generateRandomGoal()
                container.mainContext.insert(goal)
            }
            
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}


