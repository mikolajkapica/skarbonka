import SwiftData
import SwiftUI


let isPreview: Bool = true

@main
struct SkarbonkaApp: App {
    var body: some Scene {
        let router: Router = Router()
        let style = StyleConfig()
        let fontDesign = style.typography.fontDesign
        WindowGroup {
            ContentView()
                .modelContainer(DataController.createContainer(isPreview: isPreview))
                .fontDesign(fontDesign)
                .environmentObject(router)
                .environmentObject(style)
        }
    }
}
