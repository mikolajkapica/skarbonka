import XCTest

extension XCUIApplication {
    func debugPrintElements() {
        debugPrint("\n=== UI Elements Debug ===")
        debugPrint("--- Buttons ---")
        buttons.allElementsBoundByIndex.forEach { button in
            debugPrint("Button: id='\(button.identifier)' label='\(button.label)'")
        }
        
        debugPrint("\n--- All Elements ---")
        descendants(matching: .any).allElementsBoundByIndex.forEach { element in
            debugPrint("\(element.elementType): id='\(element.identifier)' label='\(element.label)'")
        }
        debugPrint("=== End Debug ===\n")
    }
} 