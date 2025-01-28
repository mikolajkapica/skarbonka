import SwiftData
import SwiftUI

let isPreview: Bool = false

@main
struct SkarbonkaApp: App {
    var body: some Scene {
        let style = StyleConfig()
        let fontDesign = style.typography.fontDesign
        WindowGroup {
            ContentView()
                .modelContainer(
                    DataController.createContainer(isPreview: isPreview)
                )
                .environmentObject(Router())
                .environmentObject(style)
                .fontDesign(fontDesign)
        }
    }
}
