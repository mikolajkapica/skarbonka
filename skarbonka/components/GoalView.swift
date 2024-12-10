import SwiftUI

struct GoalView: View {
    @State var goal = Goal(
        goalName: "Bilet do EnergyLandii",
        productPrice: 129,
        currentSavings: 77,
        savingFrequency: "Co tydzień",
        savingAmount: 11.0,
        targetDate: Calendar.current.date(
            byAdding: .day, value: 16, to: Date())!,
        currency: "zł",
        icon: "cat"
    )

    var icons = [
        "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    @State var selectedOption = Optional<String>.none

    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "Goal")
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 32) {
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
                                        goal.selectedIcon = icon
                                    }) {
                                        Image(systemName: icon)
                                            .foregroundColor(goal.selectedIcon == icon ? SkarbonkaColors.Orange : SkarbonkaColors.black)
                                            .font(.system(size: 40))
                                            .frame(width: 100, height: 100)
                                            .background(SkarbonkaColors.white)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }

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
                                                self.goal.currentSavings = intValue
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

                        Text("Select an Option")
                            .font(.headline)
                            .foregroundColor(.white)

                        RadioButtonPickerView(
                            selectedOption: $selectedOption,
                            options: ["Codziennie", "Co tydzień", "Co miesiąc"])

                        SavingsView()

                        VStack(alignment: .leading) {
                            Text("Kiedy zaczniesz oszczędzać?")
                                .font(.headline)
                                .foregroundStyle(.white)

                            CalendarView()

                        }
                        VStack(spacing: 16) {
                            NavigationLink(destination: GoalConfirmation(goal: goal)) {
                                Text("Dalej")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(SkarbonkaColors.Orange)
                                    .cornerRadius(.infinity)
                            }

                            Button(action: {
                                print("Saving goal updated")
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
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
