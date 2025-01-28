import Testing
import SwiftData
@testable import Skarbonka

@MainActor
struct GoalSummaryViewModelTests {
    @Test func testProgressCalculation() throws {
        // Given
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .weekly,
            savePerFrequency: 50,
            start: .now,
            saved: 250
        )
        let viewModel = GoalSummaryViewModel(goal: goal, modelContext: ModelContext(DataController.previewContainer))
        
        // When
        let progress = viewModel.progress
        
        // Then
        #expect(progress == 0.25) // 250/1000 = 0.25
    }
    
    @Test func testIsCompletedWithExactAmount() throws {
        // Given
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .weekly,
            savePerFrequency: 50,
            start: .now,
            saved: 1000
        )
        let viewModel = GoalSummaryViewModel(goal: goal, modelContext: ModelContext(DataController.previewContainer))
        
        // Then
        #expect(viewModel.isCompleted())
    }
    
    @Test func testIsCompletedWithExcessAmount() throws {
        // Given
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .weekly,
            savePerFrequency: 50,
            start: .now,
            saved: 1200
        )
        let viewModel = GoalSummaryViewModel(goal: goal, modelContext: ModelContext(DataController.previewContainer))
        
        // Then
        #expect(viewModel.isCompleted())
    }
    
    @Test func testGetAmountToSaveDaily() throws {
        // Given
        let goal = GoalModel(
            name: "Test Goal",
            icon: "star",
            price: 1000,
            frequency: .daily,
            savePerFrequency: 50,
            start: .now,
            saved: 0
        )
        let viewModel = GoalSummaryViewModel(goal: goal, modelContext: ModelContext(DataController.previewContainer))
        
        // Then
        #expect(viewModel.getAmountToSave() == 50)
    }
} 
