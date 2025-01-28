import XCTest

final class GoalFormViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // Configure the application
        app.launchArguments = ["UI-Testing"]
        app.launchEnvironment = ["ENV": "TEST"]
        
        // Launch the application
        app.launch()
        
        // Navigate to GoalFormView
        let addButton = app.buttons["addNewGoalButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testFormValidation() throws {
        let nameField = app.textFields["goalNameField"]
        let priceField = app.textFields["goalPriceField"]
        let savingsField = app.textFields["currentSavingsField"]
        let confirmButton = app.buttons["confirmButton"]
        
        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        
        // Initially button should be disabled
        XCTAssertFalse(confirmButton.isEnabled)
        
        // Fill in valid data
        nameField.tap()
        nameField.typeText("New Car")
        
        priceField.tap()
        priceField.typeText("50000")
        
        savingsField.tap()
        savingsField.typeText("1000")
        
        // Button should be enabled now
        XCTAssertTrue(confirmButton.isEnabled)
    }
    
    func testCancelButton() throws {
        let cancelButton = app.buttons["cancelButton"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        
        cancelButton.tap()
        
        // Verify we're back on the main screen
        XCTAssertTrue(app.buttons["addNewGoalButton"].waitForExistence(timeout: 5))
    }
    
    func testSuccessfulGoalCreation() throws {
        // Fill in the form
        let nameField = app.textFields["goalNameField"]
        let priceField = app.textFields["goalPriceField"]
        let savingsField = app.textFields["currentSavingsField"]
        
        nameField.tap()
        nameField.typeText("Vacation")
        
        priceField.tap()
        priceField.typeText("5000")
        
        savingsField.tap()
        savingsField.typeText("1000")
        
        app.buttons["keyboard.chevron.compact.down"].tap()
        
        let monthlyOption = app.buttons.matching(identifier: "frequencyPicker").element(boundBy: 2)
        XCTAssertTrue(app.scrollViews.firstMatch.scrollTo(element: monthlyOption))
        monthlyOption.tap()
        
        // Find and tap confirm button
        let confirmButton = app.buttons["confirmButton"]
        XCTAssertTrue(app.scrollViews.firstMatch.scrollTo(element: confirmButton))
        confirmButton.tap()
        
        // Verify we're on the confirmation screen by checking if any text contains "Vacation"
        let confirmationText = app.staticTexts.element(matching: NSPredicate(format: "label CONTAINS 'Vacation'"))
        XCTAssertTrue(confirmationText.waitForExistence(timeout: 5), "Could not find text containing 'Vacation'")
    }
    
    func testKeyboardDismissal() throws {
        let nameField = app.textFields["goalNameField"]
        
        nameField.tap()
        
        // Verify keyboard is shown
        XCTAssertTrue(app.keyboards.element.exists)
        
        // Tap keyboard dismiss button
        app.buttons["keyboard.chevron.compact.down"].tap()
        
        // Verify keyboard is dismissed
        XCTAssertFalse(app.keyboards.element.exists)
    }
} 
