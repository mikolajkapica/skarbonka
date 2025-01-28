import XCTest

final class SkarbonkaUITestsLaunchTests: XCTestCase {
    let app = XCUIApplication()

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["UI-Testing"]
        app.launchEnvironment = ["ENV": "TEST"]
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }

    func testLaunch() throws {
        // Given
        let maxRetries = 3
        var launchSuccess = false
        var currentTry = 0
        
        // When
        while !launchSuccess && currentTry < maxRetries {
            do {
                app.launch()
                
                // Verify basic UI elements are present
                let addButton = app.buttons["addNewGoalButton"]
                XCTAssertTrue(addButton.waitForExistence(timeout: 5))
                
                // Take screenshot
                let attachment = XCTAttachment(screenshot: app.screenshot())
                attachment.name = "Launch Screen"
                attachment.lifetime = .keepAlways
                add(attachment)
                
                launchSuccess = true
            } catch {
                currentTry += 1
                if currentTry == maxRetries {
                    XCTFail("Failed to launch app after \(maxRetries) attempts: \(error)")
                }
                // Wait before retry
                Thread.sleep(forTimeInterval: 2.0)
            }
        }
    }

    @MainActor
    func testLaunchPerformance() throws {
        guard #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) else {
            return
        }
        
        // Configure metrics
        let metrics: [XCTMetric] = [
            XCTApplicationLaunchMetric(),
            XCTMemoryMetric(),
            XCTCPUMetric()
        ]
        
        // Measure launch performance
        measure(metrics: metrics) {
            app.launch()
            
            // Verify app launched successfully
            let addButton = app.buttons["addNewGoalButton"]
            XCTAssertTrue(addButton.waitForExistence(timeout: 5))
            
            app.terminate()
        }
    }
}
