import SwiftData
import SwiftUI

let isPreview: Bool = false

@main
struct SkarbonkaApp: App {
    private let style: StyleConfig
    private let container: ModelContainer
    private let context: ModelContext
    private let router: Router
    
    init() {
        style = StyleConfig()
        container = DataController.createContainer(isPreview: isPreview)
        context = ModelContext(container)
        router = Router(modelContext: context)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContext(context)
                .environmentObject(router)
                .environmentObject(style)
                .fontDesign(style.typography.fontDesign)
        }
    }
}
