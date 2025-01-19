import SwiftData
import SwiftUI

@main
struct SkarbonkaApp: App {
    @Environment(\.modelContext) private var context
    @StateObject private var router = Router()
    @StateObject private var style = StyleConfig()
    
    
    let container = DataController.previewContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .modelContainer(for: GoalModel.self)
                .modelContainer(container)
                .fontDesign(style.typography.fontDesign)
                .environmentObject(router)
                .environmentObject(style)
        }
    }
}
