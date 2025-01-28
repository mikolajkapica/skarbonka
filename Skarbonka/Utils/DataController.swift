import SwiftUI
import SwiftData

// MARK: - Data Controller
@MainActor
class DataController {
    // MARK: - Static Properties
    static let previewContainer: ModelContainer = createContainer(isPreview: true)
    static let container: ModelContainer = createContainer(isPreview: false)
    
    // MARK: - Container Creation
    static func createContainer(isPreview: Bool) -> ModelContainer {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: isPreview)
            let container = try ModelContainer(
                for: GoalModel.self,
                configurations: config
            )
            
            if isPreview {
                populatePreviewData(in: container)
            }
            
            return container
        } catch {
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private Methods
    private static func populatePreviewData(in container: ModelContainer) {
        for _ in 1...9 {
            let goal = generateRandomGoal()
            container.mainContext.insert(goal)
        }
    }
}


