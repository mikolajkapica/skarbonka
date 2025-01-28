import XCTest

final class E2ETests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["UI-Testing"]
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testCompleteGoalCreationFlow() throws {
        let addButton = app.buttons["addNewGoalButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        
        addButton.tap()
        
        let nameField = app.textFields["goalNameField"]
        let priceField = app.textFields["goalPriceField"]
        let savingsField = app.textFields["currentSavingsField"]
        
        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        
        nameField.tap()
        let randomName = "Goal \(Int.random(in: 1...1000))"
        nameField.typeText(randomName)
        
        priceField.tap()
        let randomPrice = "\(Int.random(in: 100...10000))"
        priceField.typeText(randomPrice)
        
        savingsField.tap()
        let randomSavings = "\(Int.random(in: 100...10000))"
        savingsField.typeText(randomSavings)
        
        app.buttons["keyboard.chevron.compact.down"].tap()
        
        let weeklyOption = app.buttons.matching(identifier: "frequencyPicker").element(boundBy: 1) // "Co tydzień"
        XCTAssertTrue(app.scrollViews.firstMatch.scrollTo(element: weeklyOption))
        weeklyOption.tap()
        
        let confirmButton = app.buttons["confirmButton"]
        XCTAssertTrue(app.scrollViews.firstMatch.scrollTo(element: confirmButton))
        confirmButton.tap()
        
        let confirmationText = app.staticTexts.element(matching: NSPredicate(format: "label CONTAINS '\(randomName)'"))
        XCTAssertTrue(confirmationText.waitForExistence(timeout: 5))
        
        let finalConfirmButton = app.buttons["saveButton"]
        XCTAssertTrue(finalConfirmButton.waitForExistence(timeout: 5))
        finalConfirmButton.tap()
        
        XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Should be back on home screen")
        
        let goalSummary = app.staticTexts.element(matching: NSPredicate(format: "label CONTAINS '\(randomName)'"))
        XCTAssertTrue(app.scrollViews.firstMatch.scrollTo(element: goalSummary))
        XCTAssertTrue(goalSummary.exists, "New goal should appear in the list")
    }
} 
