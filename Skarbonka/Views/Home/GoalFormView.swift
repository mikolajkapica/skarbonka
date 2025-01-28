import SwiftUI

struct GoalFormView: View {
    @ObservedObject var viewModel: GoalFormViewModel = GoalFormViewModel()
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext

    @State private var goalName: String = ""
    @State private var goalPrice: String = ""
    @State private var currentSavings: String = ""

    enum FocusedField { case int, dec }
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                goalNameFieldView
                iconSelectionView
                priceAndSavingsView
                optionSelectionView
                SavingsView(
                    savePerFrequencyBinding: viewModel.savePerFrequencyBinding,
                    calculatedDays: viewModel.calculateDays(viewModel.goal)
                )
                startSavingDateView
                actionButtonsView
            }
            .padding(24)
        }
        .navigationBarBackButtonHidden(true)
        .background(style.theme.backgroundGradient)
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

            TextField("np. karty PokemonGo", text: $goalName)
                .onChange(of: goalName) { _, newValue in
                    viewModel.updateGoalName(newValue)
                }
                .focused($focusedField, equals: FocusedField.int)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(.infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(
                            viewModel.goalNameError == nil
                                ? Color.clear : Color.red, lineWidth: 2)
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
                text: $goalPrice
            )
            .onChange(of: goalPrice) { _, newValue in
                viewModel.updateGoalPrice(newValue)
            }
            .keyboardType(.numberPad)
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        viewModel.goalPriceError == nil
                            ? Color.clear : Color.red, lineWidth: 2)
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
                text: $currentSavings
            )
            .onChange(of: currentSavings) { _, newValue in
                viewModel.updateCurrentSavings(newValue)
            }
            .keyboardType(.numberPad)
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        viewModel.currentSavingsError == nil
                            ? Color.clear : Color.red, lineWidth: 2)
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
            Button(
                action: {
                    router.navigate(
                        to: Route.goalConfirmation(goal: viewModel.goal))
                }
            ) {
                Text("Dalej").frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(FilledButton())
            .disabled(
                !viewModel.isGoalValid(
                    name: goalName,
                    price: goalPrice,
                    savings: currentSavings
                ))

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
