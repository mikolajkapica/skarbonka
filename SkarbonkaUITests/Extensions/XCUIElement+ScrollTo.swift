import XCTest

extension XCUIElement {
    enum ScrollDirection {
        case up, down
    }
    
    func scrollTo(element: XCUIElement, direction: ScrollDirection = .up, maxSwipes: Int = 10) -> Bool {
        var swipeCount = 0
        let coordinate = coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        
        while !element.exists && swipeCount < maxSwipes {
            switch direction {
            case .up:
                // Small swipe up (about 20% of the screen)
                coordinate.press(forDuration: 0.01, thenDragTo: coordinate.withOffset(CGVector(dx: 0, dy: -50)))
            case .down:
                // Small swipe down (about 20% of the screen)
                coordinate.press(forDuration: 0.01, thenDragTo: coordinate.withOffset(CGVector(dx: 0, dy: 50)))
            }
            swipeCount += 1
            // Small pause to let the scroll settle
            Thread.sleep(forTimeInterval: 0.2)
        }
        
        return element.exists
    }
} 