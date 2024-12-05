import SwiftUI

struct GoalView: View {
    @State private var goalName: String = "Bilet do EnergyLandii"
    @State private var selectedIcon: String? = "puzzlepiece"  // Default icon
    @State private var productPrice: String = "129"
    @State private var currentSavings: String = "77"
    @State private var savingFrequency: String = "Co tydzień"
    @State private var savingAmount: Double = 11.0
    @State private var targetDate: Date = Calendar.current.date(
        byAdding: .day, value: 16, to: Date())!

    @Environment(\.presentationMode) var presentationMode

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
                        //                    Text("Bilet do EnergyLandii")
                        //                        .font(.title)
                        //                        .fontWeight(.bold)

                        VStack(alignment: .leading) {
                            Text("Wpisz nazwę Twojego celu")
                                .foregroundColor(.white)
                                .font(.headline)

                            TextField("np. karty PokemonGo", text: $goalName)
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
                                        selectedIcon = icon
                                    }) {
                                        Image(systemName: icon)
                                            .foregroundColor(
                                                SkarbonkaColors.black
                                            )
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
                                TextField("Cena produktu", text: $productPrice)
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
                                    "Obecne oszczędności", text: $currentSavings
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
                            Button(action: {
                                print("Saving goal updated")
                            }) {
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

                        VStack {
                            let msg = [
                                "Oszczędzaj ", "5zł",
                                " tygodniowo i ciesz się z zakupu Puzzle za 80zł",
                            ]

                                (Text(msg[0])
                                    + Text(msg[1]).foregroundStyle(
                                        SkarbonkaColors.Orange)
                                 + Text(msg[2])).frame(maxWidth: CGFloat(290))

                                Image(systemName: "puzzlepiece")
                                    .foregroundColor(
                                        SkarbonkaColors.black
                                    )
                                    .font(.system(size: 80))
                                    .frame(width: 170, height: 170)
                                    .background(SkarbonkaColors.white)
                                    .clipShape(Circle())
                                
                                Text("już za 16 tygodni (29 kwietnia)")
                        }
                        .foregroundStyle(.white)
                        .font(SkarbonkaTextSize.m.fontSize)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)

                        VStack(spacing: 16) {
                            Button(action: {
                                print("Saving goal updated")
                            }) {
                                Text("Zapisz cel")
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
