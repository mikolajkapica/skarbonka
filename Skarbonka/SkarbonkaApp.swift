import SwiftData
import SwiftUI

@main
struct SkarbonkaApp: App {
    @Environment(\.modelContext) private var context
    @StateObject private var router = Router()
    @StateObject private var configuration = Configuration()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Goal.self)
                .fontDesign(configuration.fontDesign)
                .environmentObject(router)
                .environmentObject(configuration)
        }
    }
}
