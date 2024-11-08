//
//  skarbonkaApp.swift
//  skarbonka
//
//  Created by stud on 29/10/2024.
//

import SwiftUI
import SwiftData

@main
struct skarbonkaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(\.font, .system(.body, design: .rounded))
        .modelContainer(sharedModelContainer)
    }
}
