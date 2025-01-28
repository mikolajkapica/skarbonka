import Testing
@testable import Skarbonka

struct GoalFormViewModelTests {
    @Test func testCalculateDaysForDailyFrequency() throws {
        // Given
        let viewModel = GoalFormViewModel()
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .daily,
            savePerFrequency: 100,
            start: .now,
            saved: 200
        )
        
        // When
        let days = viewModel.calculateDays(goal)
        
        // Then
        #expect(days == 8) // (1000-200)/100 = 8 days
    }
    
    @Test func testCalculateDaysForWeeklyFrequency() throws {
        // Given
        let viewModel = GoalFormViewModel()
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .weekly,
            savePerFrequency: 200,
            start: .now,
            saved: 200
        )
        
        // When
        let days = viewModel.calculateDays(goal)
        
        // Then
        #expect(days == 28) // ((1000-200)/200) * 7 = 28 days
    }
    
    @Test func testCalculateDaysForMonthlyFrequency() throws {
        // Given
        let viewModel = GoalFormViewModel()
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .monthly,
            savePerFrequency: 200,
            start: .now,
            saved: 200
        )
        
        // When
        let days = viewModel.calculateDays(goal)
        
        // Then
        #expect(days == 120) // ((1000-200)/200) * 30 = 120 days
    }
    
    @Test func testValidationWithInvalidGoalName() throws {
        // Given
        let viewModel = GoalFormViewModel()
        
        // When/Then
        #expect(!viewModel.isGoalValid(name: "", price: "1000", savings: "0"))
        #expect(!viewModel.isGoalValid(name: "   ", price: "1000", savings: "0"))
    }
    
    @Test func testValidationWithInvalidPrice() throws {
        // Given
        let viewModel = GoalFormViewModel()
        
        // When/Then
        #expect(!viewModel.isGoalValid(name: "Test", price: "0", savings: "0"))
        #expect(!viewModel.isGoalValid(name: "Test", price: "-100", savings: "0"))
        #expect(!viewModel.isGoalValid(name: "Test", price: "abc", savings: "0"))
    }
    
    @Test func testValidationWithInvalidSavings() throws {
        // Given
        let viewModel = GoalFormViewModel()
        
        // When/Then
        #expect(!viewModel.isGoalValid(name: "Test", price: "1000", savings: "-100"))
        #expect(!viewModel.isGoalValid(name: "Test", price: "1000", savings: "abc"))
        #expect(!viewModel.isGoalValid(name: "Test", price: "1000", savings: "2000"))
    }
} 
