import SwiftUI

struct GoalFormView: View {
    @ObservedObject var viewModel: GoalFormViewModel = GoalFormViewModel()
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext

    enum FocusedField { case int, dec }
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                goalNameFieldView
                iconSelectionView
                priceAndSavingsView
                optionSelectionView
                SavingsView(viewModel: SavePerFrequencyViewModel(goal: viewModel.goal))
                startSavingDateView
                actionButtonsView
            }
            .padding(24)
        }
        .navigationBarBackButtonHidden(true)
        .background(style.theme.backgroundGradient)
        .navigationDestination(isPresented: $viewModel.isGoalCompleted) {
            GoalConfirmation(
                viewModel: GoalConfirmationViewModel(
                    context: modelContext, goal: viewModel.goal))
        }
        .toolbar {
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
        .topBarTitle("Oszczędności")
    }

    private var goalNameFieldView: some View {
        VStack(alignment: .leading) {
            Text("Wpisz nazwę Twojego celu")
                .foregroundColor(.white)
                .font(.headline)

            TextField("np. karty PokemonGo", text: $viewModel.goal.name, onEditingChanged: { _ in
                viewModel.validateGoalName()
            })
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(.infinity)
            .overlay(
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(viewModel.goalNameError == nil ? Color.clear : Color.red, lineWidth: 2)
            )

            if let error = viewModel.goalNameError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }

    private var iconSelectionView: some View {
        VStack(alignment: .leading) {
            Text("Wybierz grafikę")
                .font(.headline)
                .foregroundColor(.white)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ], spacing: 16
            ) {
                ForEach(viewModel.icons, id: \.self) { icon in
                    Button(action: { viewModel.goal.icon = icon }) {
                        Image(systemName: icon)
                            .foregroundColor(
                                viewModel.goal.icon == icon
                                    ? style.theme.primary
                                    : style.theme.background
                            )
                            .font(.system(size: 40))
                            .frame(width: 100, height: 100)
                            .background(style.theme.foreground)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }

    private var priceAndSavingsView: some View {
        VStack(spacing: 20) {
            priceFieldView
            currentSavingsFieldView
        }
    }

    private var priceFieldView: some View {
        VStack(alignment: .leading) {
            Text("Cena produktu")
                .bold()
                .foregroundStyle(.white)

            TextField(
                "Wprowadź cenę",
                text: Binding(
                    get: { String(viewModel.goal.price) },
                    set: { viewModel.updateGoalPrice($0) }
                )
            )
            .keyboardType(.numberPad)
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.goalPriceError == nil ? Color.clear : Color.red, lineWidth: 2)
            )

            if let error = viewModel.goalPriceError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }

    private var currentSavingsFieldView: some View {
        VStack(alignment: .leading) {
            Text("Teraz w skarbonce masz:")
                .bold()
                .foregroundStyle(.white)

            TextField(
                "Obecne oszczędności",
                text: Binding(
                    get: { String(viewModel.goal.saved) },
                    set: { viewModel.updateCurrentSavings($0) }
                )
            )
            .keyboardType(.numberPad)
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.currentSavingsError == nil ? Color.clear : Color.red, lineWidth: 2)
            )

            if let error = viewModel.currentSavingsError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }

    private var optionSelectionView: some View {
        VStack(alignment: .leading) {
            Text("Jak często będziesz oszczędzal?")
                .font(.headline)
                .foregroundColor(.white)

            RadioButtonPickerView(
                options: ["Codziennie", "Co tydzień", "Co miesiąc"],
                selectedOption: $viewModel.selectedOption
            )
        }
    }

    private var startSavingDateView: some View {
        VStack(alignment: .leading) {
            Text("Kiedy zaczniesz oszczędzać?")
                .font(.headline)
                .foregroundStyle(.white)

            CalendarView()
        }
    }

    private var actionButtonsView: some View {
        VStack(spacing: 16) {
            Button(action: {
                viewModel.isGoalCompleted = true
            }) {
                Text("Dalej").frame(maxWidth: .infinity)
            }
            .buttonStyle(FilledButton())
            .disabled(!viewModel.isGoalValid())

            Button(action: {
                router.path.removeLast()
            }) {
                Text("Anuluj").frame(maxWidth: .infinity)
            }
            .buttonStyle(MutedButton())
            .frame(maxWidth: .infinity)
        }
    }
}
