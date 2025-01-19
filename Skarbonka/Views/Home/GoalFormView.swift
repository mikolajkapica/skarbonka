import SwiftUI

struct GoalFormView: View {
    @ObservedObject var viewModel: GoalFormViewModel = GoalFormViewModel()
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router
    @Environment(\.modelContext) private var modelContext

    enum FocusedField { case int, dec }
    @FocusState private var focusedField: FocusedField?

    // Alert state
    @State private var showAlert = false
    @State private var alertMessage = ""

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
            router.path.append(viewModel.goal)
            return GoalConfirmation(
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

            TextField("np. karty PokemonGo", text: $viewModel.goal.name)
                .focused($focusedField, equals: FocusedField.int)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(.infinity)
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
            Text(String(localized: "Cena produktu"))
                .bold()
                .foregroundStyle(.white)
            TextField(
                "fsdg",
                text: Binding(
                    get: { String(viewModel.goal.price) },
                    set: { newValue in viewModel.updateGoalPrice(newValue) }
                )
            )
            .keyboardType(.numberPad)
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
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
                    set: { newValue in viewModel.updateCurrentSavings(newValue)
                    }
                )
            )
            .keyboardType(.numberPad)
            .focused($focusedField, equals: FocusedField.int)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }

    private var optionSelectionView: some View {
        VStack(alignment: .leading) {
            Text(String("Jak często będziesz oszczędzal?"))
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
                if viewModel.isGoalValid() {
                    viewModel.isGoalCompleted = true
                } else {
                    alertMessage = "Please fill in all required fields"
                    showAlert = true
                }
            }) {
                Text("Dalej").frame(maxWidth: .infinity)
            }
            .buttonStyle(FilledButton())
            .disabled(!viewModel.isGoalValid()) // Disable button if validation fails

            Button(action: {
                router.path.removeLast()
            }) {
                Text("Anuluj").frame(maxWidth: .infinity)
            }
            .buttonStyle(MutedButton())
            .frame(maxWidth: .infinity)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    let viewModel = GoalFormViewModel()
    GoalFormView(viewModel: viewModel)
        .environmentObject(StyleConfig())
        .environmentObject(Router())
}
