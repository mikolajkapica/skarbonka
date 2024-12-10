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
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ContentView()
                    .fontDesign(.rounded)

            }
        }
        .environment(\.font, .system(.body, design: .rounded))
        .modelContainer(for: Goal.self)
    }
}
