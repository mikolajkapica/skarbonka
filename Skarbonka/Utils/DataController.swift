import SwiftUI
import SwiftData

@MainActor
class DataController {
    static func createContainer(isPreview: Bool) -> ModelContainer {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: isPreview)
            let container = try ModelContainer(for: GoalModel.self, configurations: config)
            
            if isPreview {
                for _ in 1...9 {
                    let goal = generateRandomGoal()
                    container.mainContext.insert(goal)
                }
            }
            
            return container
        } catch {
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }
    
    static let previewContainer: ModelContainer = createContainer(isPreview: true)
    static let container: ModelContainer = createContainer(isPreview: false)
}


