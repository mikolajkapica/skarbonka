import SwiftUI
import SwiftData

@main
struct SkarbonkaApp: App {
    
    @Environment(\.modelContext) private var context
    
    var body: some Scene {
        WindowGroup {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    ContentView()
                        .fontDesign(.rounded)
                }
                .environment(\.font, .system(.body, design: .rounded))
                .modelContainer(for: Goal.self)

            
            
//                    let goal = Goal(
//                        goalName: "New Laptop",
//                        selectedIcon: "laptopcomputer",
//                        productPrice: 999,
//                        currentSavings: 450,
//                        savingFrequency: "Bi-weekly",
//                        savingAmount: 25.0,
//                        targetDate: Calendar.current.date(
//                            byAdding: .day, value: 60, to: Date())!,
//                        currency: "zł",
//                        icon: "cat"
//                    )
//            } else {
//                ProgressView()  // Show a loading indicator until the modelContext is ready
//                    .progressViewStyle(CircularProgressViewStyle())
//            }
        }
        
    }
    
}

