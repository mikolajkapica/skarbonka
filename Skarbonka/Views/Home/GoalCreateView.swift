import SwiftUI

struct GoalCreateView: View {
//    @State var goal = Goal(
//        goalName: "",
//        icon: "cat",
//        productPrice: 0,
//        currentSavings: 10,
//        savingFrequency: 1,
//        savingAmount: 50,
//        targetDate: Date(),
//        currency: "zł"
//    )
//    @State var selectedOption: String? = nil
//    @State var isGoalCompleted: Bool = false
//
//    var icons = [
//        "cat", "bicycle", "ticket", "puzzlepiece", "music.note", "photo",
//    ]
//
//    @Environment(\.presentationMode) private var presentationMode
//    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(spacing: 0) {
//            ScrollView {
//                VStack {
//                    VStack(alignment: .leading, spacing: 32) {
//                        // Goal Name
//                        Button(
//                            action: { print(Router.shared.path) }
//                        ) { Text("Log") }
//                        VStack(alignment: .leading) {
//                            Text("Wpisz nazwę Twojego celu")
//                                .foregroundColor(.white)
//                                .font(.headline)
//                            
//                            TextField(
//                                "np. karty PokemonGo", text: $goal.goalName
//                            )
//                            .padding()
//                            .background(Color(.systemGray6))
//                            .cornerRadius(.infinity)
//                        }
//                        
//                        VStack(alignment: .leading) {
//                            Text("Wybierz grafikę")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                            
//                            LazyVGrid(
//                                columns: [
//                                    GridItem(.flexible()),
//                                    GridItem(.flexible()),
//                                    GridItem(.flexible()),
//                                ], spacing: 16
//                            ) {
//                                ForEach(icons, id: \.self) { icon in
//                                    Button(action: {
//                                        goal.icon = icon
//                                    }) {
//                                        Image(systemName: icon)
//                                            .foregroundColor(
//                                                goal.icon == icon
//                                                ? SkarbonkaColors.Orange
//                                                : SkarbonkaColors.black
//                                            )
//                                            .font(.system(size: 40))
//                                            .frame(width: 100, height: 100)
//                                            .background(SkarbonkaColors.white)
//                                            .clipShape(Circle())
//                                    }
//                                }
//                            }
//                        }
//                        
//                        VStack {
//                            HStack {
//                                Text("Cena produktu")
//                                Spacer()
//                                TextField(
//                                    "Cena produktu",
//                                    text: Binding(
//                                        get: {
//                                            String(self.goal.productPrice)
//                                        },
//                                        set: { newValue in
//                                            if let intValue = Int(newValue) {
//                                                self.goal.productPrice =
//                                                intValue
//                                            }
//                                        }
//                                    )
//                                )
//                                .keyboardType(.numberPad)
//                                .multilineTextAlignment(.trailing)
//                            }
//                            .padding()
//                            .background(Color(.systemGray6))
//                            .cornerRadius(8)
//                            
//                            // Current Savings
//                            HStack {
//                                Text("Teraz w skarbonce masz:")
//                                Spacer()
//                                TextField(
//                                    "Obecne oszczędności",
//                                    text: Binding(
//                                        get: {
//                                            String(self.goal.currentSavings)
//                                        },
//                                        set: { newValue in
//                                            if let intValue = Int(newValue) {
//                                                self.goal.currentSavings =
//                                                intValue
//                                            }
//                                        }
//                                    )
//                                )
//                                .keyboardType(.numberPad)
//                                .multilineTextAlignment(.trailing)
//                            }
//                            .padding()
//                            .background(Color(.systemGray6))
//                            .cornerRadius(8)
//                        }
//                        
//                        Text("Select an Option")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                        
//                        RadioButtonPickerView(
//                            selectedOption: $selectedOption,
//                            options: ["Codziennie", "Co tydzień", "Co miesiąc"])
//                        
//                        VStack(alignment: .leading) {
//                            Text("Kiedy zaczniesz oszczędzać?")
//                                .font(.headline)
//                                .foregroundStyle(.white)
//                            
//                            CalendarView()
//                            
//                        }
//                        
//                        VStack(spacing: 16) {
//                            Button(action: {
//                                isGoalCompleted =
//                                !goal.goalName.isEmpty
//                                && goal.productPrice > 0
//                                && goal.currentSavings >= 0
//                                && selectedOption != nil
//                                && goal.icon != ""
//                            }) {
//                                Text("Dalej")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(SkarbonkaColors.Orange)
//                                    .cornerRadius(.infinity)
//                            }
//                            
//                            Button(action: {
//                                self.presentationMode.wrappedValue.dismiss()  // Go back
//                            }) {
//                                Text("Anuluj")
//                                    .font(.headline)
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(SkarbonkaColors.white)
//                                    .cornerRadius(.infinity)
//                            }
//                        }
//                    }
//                }
//                .padding(24)
//            }
//            .background(SkarbonkaColors.PurpleGradient)
//            .navigationDestination(isPresented: $isGoalCompleted) {
//                GoalConfirmation(goal: goal)
//            }
        }
        .topBarTitle("GoalCreateView")
    }
}
