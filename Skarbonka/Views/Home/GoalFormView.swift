import SwiftUI

struct GoalFormView: View {
    @ObservedObject var viewModel: GoalFormViewModel = GoalFormViewModel()
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - Form State
    @State private var goalName: String = ""
    @State private var goalPrice: String = ""
    @State private var currentSavings: String = ""
    
    // MARK: - Focus State
    enum FocusedField { case int, dec }
    @FocusState private var focusedField: FocusedField?
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                goalNameFieldView
                iconSelectionView
                priceAndSavingsView
                optionSelectionView
                SavingsView(
                    savePerFrequency: viewModel.savePerFrequencyBinding,
                    calculatedDays: viewModel.calculateDays(viewModel.goal)
                )
                startSavingDateView
                actionButtonsView
            }
            .padding(24)
        }
        .navigationBarBackButtonHidden(true)
        .background(style.theme.backgroundGradient)
        .toolbar { toolbarContent }
        .topBarTitle("Oszczędności")
    }
}

// MARK: - Toolbar Content
private extension GoalFormView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            Spacer()
        }
        ToolbarItem(placement: .keyboard) {
            Button {
                focusedField = nil
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
    }
}

// MARK: - Form Components
private extension GoalFormView {
    var goalNameFieldView: some View {
        FormField(
            title: "Wpisz nazwę Twojego celu",
            placeholder: "np. karty PokemonGo",
            text: $goalName,
            error: viewModel.goalNameError
        ) {
            viewModel.updateGoalName($0)
        }
        .focused($focusedField, equals: .int)
    }
    
    var iconSelectionView: some View {
        IconSelectionGrid(
            selectedIcon: $viewModel.goal.icon,
            icons: viewModel.icons,
            style: style
        )
    }
    
    var priceAndSavingsView: some View {
        VStack(spacing: 20) {
            priceFieldView
            currentSavingsFieldView
        }
    }
    
    var priceFieldView: some View {
        FormField(
            title: "Cena produktu",
            placeholder: "Wprowadź cenę",
            text: $goalPrice,
            error: viewModel.goalPriceError,
            keyboardType: .numberPad
        ) {
            viewModel.updateGoalPrice($0)
        }
        .focused($focusedField, equals: .int)
    }
    
    var currentSavingsFieldView: some View {
        FormField(
            title: "Teraz w skarbonce masz:",
            placeholder: "Obecne oszczędności",
            text: $currentSavings,
            error: viewModel.currentSavingsError,
            keyboardType: .numberPad
        ) {
            viewModel.updateCurrentSavings($0)
        }
        .focused($focusedField, equals: .int)
    }
    
    var optionSelectionView: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "Jak często będziesz oszczędzal?"))
                .font(.headline)
                .foregroundColor(.white)
            
            RadioButtonPicker(
                selectedOption: $viewModel.selectedOption,
                options: [
                    String(localized: "Codziennie"),
                    String(localized: "Co tydzień"),
                    String(localized: "Co miesiąc")
                ]
            )
        }
    }
    
    var startSavingDateView: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "Kiedy zaczniesz oszczędzać?"))
                .font(.headline)
                .foregroundStyle(.white)
            
            DatePickerCard()
        }
    }
    
    var actionButtonsView: some View {
        VStack(spacing: 16) {
            Button(action: navigateToConfirmation) {
                Text(String(localized: "Dalej")).frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(FilledButton())
            .disabled(!isFormValid)
            
            Button(action: dismissForm) {
                Text(String(localized: "Anuluj")).frame(maxWidth: .infinity)
            }
            .buttonStyle(MutedButton())
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Actions
private extension GoalFormView {
    var isFormValid: Bool {
        viewModel.isGoalValid(
            name: goalName,
            price: goalPrice,
            savings: currentSavings
        )
    }
    
    func navigateToConfirmation() {
        router.navigate(to: Route.goalConfirmation(goal: viewModel.goal))
    }
    
    func dismissForm() {
        router.path.removeLast()
    }
}
