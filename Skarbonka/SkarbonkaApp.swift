import SwiftData
import SwiftUI

@main
struct SkarbonkaApp: App {
    @Environment(\.modelContext) private var context
    @StateObject private var router = Router()
    @StateObject private var style = StyleConfig()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: GoalModel.self)
                .fontDesign(style.typography.fontDesign)
                .foregroundColor(.white)
                .environmentObject(router)
                .environmentObject(style)
        }
    }
}
