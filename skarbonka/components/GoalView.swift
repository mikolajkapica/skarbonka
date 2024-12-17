import SwiftUI

struct GoalView: View {
    @State var goal = Goal(
        goalName: "",
        icon: "cat",
        productPrice: 0,
        currentSavings: 10,
        savingFrequency: 1,
        savingAmount: 50,
        targetDate: Date(),
        currency: "zł"
    )

    var icons = [
        "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    @State var selectedOption: String? = nil

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext

    @State var isGoalCompleted: Bool = false

    //    @State var isGoalComplete: Bool = false;
    // Function to check if the goal is complete
    //    func isGoalComplete() -> Bool {
    //        print("isGoalComplete")
    //        var completed =
    //
    //        if (!completed) {
    //            buttonClicked = false
    //        }
    //
    //        return completed
    //    }
    //

    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "Goal")
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 32) {
                        // Goal Name
                        VStack(alignment: .leading) {
                            Text("Wpisz nazwę Twojego celu")
                                .foregroundColor(.white)
                                .font(.headline)

                            TextField(
                                "np. karty PokemonGo", text: $goal.goalName
                            )
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(.infinity)
                        }

                        VStack(alignment: .leading) {
                            Text("Wybierz grafikę")
                                .font(.headline)
                                .foregroundColor(.white)

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(icons, id: \.self) { icon in
                                    Button(action: {
                                        goal.icon = icon
                                    }) {
                                        Image(systemName: icon)
                                            .foregroundColor(
                                                goal.icon == icon
                                                    ? SkarbonkaColors.Orange
                                                    : SkarbonkaColors.black
                                            )
                                            .font(.system(size: 40))
                                            .frame(width: 100, height: 100)
                                            .background(SkarbonkaColors.white)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }

                        // Product Price
                        VStack {
                            HStack {
                                Text("Cena produktu")
                                Spacer()
                                TextField(
                                    "Cena produktu",
                                    text: Binding(
                                        get: {
                                            String(self.goal.productPrice)
                                        },
                                        set: { newValue in
                                            if let intValue = Int(newValue) {
                                                self.goal.productPrice =
                                                    intValue
                                            }
                                        }
                                    )
                                )
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                            // Current Savings
                            HStack {
                                Text("Teraz w skarbonce masz:")
                                Spacer()
                                TextField(
                                    "Obecne oszczędności",
                                    text: Binding(
                                        get: {
                                            String(self.goal.currentSavings)
                                        },
                                        set: { newValue in
                                            if let intValue = Int(newValue) {
                                                self.goal.currentSavings =
                                                    intValue
                                            }
                                        }
                                    )
                                )
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }

                        // Saving Frequency (Radio Buttons)
                        Text("Select an Option")
                            .font(.headline)
                            .foregroundColor(.white)

                        RadioButtonPickerView(
                            selectedOption: $selectedOption,
                            options: ["Codziennie", "Co tydzień", "Co miesiąc"])

                        // Target Date (Calendar)
                        VStack(alignment: .leading) {
                            Text("Kiedy zaczniesz oszczędzać?")
                                .font(.headline)
                                .foregroundStyle(.white)

                            CalendarView()

                        }

                        // Button Section
                        VStack(spacing: 16) {
                            Button(action: {
                                isGoalCompleted =
                                    !goal.goalName.isEmpty
                                    && goal.productPrice > 0
                                    && goal.currentSavings >= 0
                                    && selectedOption != nil
                                    && goal.icon != ""
                            }) {
                                Text("Dalej")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(SkarbonkaColors.Orange)
                                    .cornerRadius(.infinity)
                            }

                            // Cancel button
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()  // Go back
                            }) {
                                Text("Anuluj")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(SkarbonkaColors.white)
                                    .cornerRadius(.infinity)
                            }
                        }
                    }
                }
                .padding(24)
            }
            .background(SkarbonkaColors.PurpleGradient)
            .navigationDestination(isPresented: $isGoalCompleted) {
                GoalConfirmation(goal: goal)
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
