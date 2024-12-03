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

    var body: some View {
        VStack {
            TopBar(title: "Goal")
            ScrollView {
                Text("Bilet do EnergyLandii")
                    .font(.title)
                    .fontWeight(.bold)

                // Goal name text field
                TextField("Wpisz nazwę Twojego celu", text: $goalName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                // Icon picker
                Text("Wybierz grafikę")
                    .font(.headline)

                HStack {
                    ForEach(icons, id: \.self) { icon in
                        Button(action: {
                            selectedIcon = icon
                        }) {
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(
                                    selectedIcon == icon ? .orange : .gray)
                        }
                    }
                }

                // Product price
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

                // Current savings
                HStack {
                    Text("Teraz w skarbonce masz:")
                    Spacer()
                    TextField("Obecne oszczędności", text: $currentSavings)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

                // Frequency picker
                Text("Jak często będziesz oszczędzać?")
                    .font(.headline)

                Picker(
                    "Częstotliwość oszczędzania", selection: $savingFrequency
                ) {
                    Text("Codziennie").tag("Codziennie")
                    Text("Co tydzień").tag("Co tydzień")
                    Text("Co miesiąc").tag("Co miesiąc")
                }
                .pickerStyle(SegmentedPickerStyle())

                // Saving amount slider
                VStack {
                    Text("Jaką kwotę będziesz oszczędzać?")
                        .font(.headline)

                    Slider(value: $savingAmount, in: 1...50, step: 1)
                    Text("\(Int(savingAmount)) zł")
                        .font(.title3)
                }

                // Target date
                Text("Kupisz za \(calculatedDays) dni (\(formattedDate))")
                    .font(.subheadline)

                // Save button
                Button(action: {
                    print("Saving goal updated")
                }) {
                    Text("Zapisz")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 24)
        }
    }
    // Precomputed number of days
    private var calculatedDays: Int {
        guard let price = Double(productPrice),
            let savings = Double(currentSavings),
            savingAmount > 0
        else { return 0 }
        return Int((price - savings) / savingAmount)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
