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
    
//    @UIApplicationDelegateAdaptor(AppDelegete.self) var appDelagete

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ContentView()
                    .fontDesign(.rounded)

            }
        }
        .environment(\.font, .system(.body, design: .rounded))
        .modelContainer(sharedModelContainer)
    }
}

//final class AppDelegete: UIResponder, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            if let window = application.windows.first {
//                window.backgroundColor = .systemPurple
//            }
//        }
//        return true
//    }
//}
