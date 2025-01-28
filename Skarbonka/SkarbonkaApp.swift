import SwiftData
import SwiftUI

let isPreview: Bool = false

@main
struct SkarbonkaApp: App {
    var body: some Scene {
        let style = StyleConfig()
        let fontDesign = style.typography.fontDesign
        let container = DataController.createContainer(isPreview: isPreview)
        let context = ModelContext(container)
        let router = Router(modelContext: context)
        WindowGroup {
            ContentView()
                .modelContext(context)
                .environmentObject(router)
                .environmentObject(style)
                .fontDesign(fontDesign)
        }
    }
}
