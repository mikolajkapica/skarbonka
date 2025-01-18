//import SwiftUI
//
//struct SavingsView: View {
//    @State private var savingAmount: Double = 25.0
//    var productPrice: Double = 500
//    var savings: Double = 50
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Jaką kwotę będziesz oszczędzać?")
//                .font(.headline)
//                .foregroundStyle(.white)
//
//            Slider(value: $savingAmount, in: 1...50, step: 1)
//                .accentColor(SkarbonkaColors.Orange)
//
//            TextField(
//                "Kwota", value: $savingAmount,
//                formatter: NumberFormatter.currency
//            )
//            .keyboardType(.numberPad)
//            .padding(10)
//            .background(Color(.systemGray6))
//            .cornerRadius(8)
//            .font(.title3)
//            .bold()
//
//            Text("Kupisz za \(calculatedDays) dni")
//                .font(.subheadline)
//                .foregroundStyle(.white)
//        }
//    }
//
//    // Precomputed number of days
//    private var calculatedDays: Int {
//        guard savingAmount > 0
//        else { return 0 }
//        return Int((productPrice - savings) / savingAmount)
//    }
//
//    func formattedDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        return formatter.string(from: date)
//    }
//}
//
//// Custom NumberFormatter for currency
//extension NumberFormatter {
//    static var currency: NumberFormatter {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal  // Use .currency if formatting with currency symbols
//        formatter.maximumFractionDigits = 0
//        return formatter
//    }
//}
//
//struct SavingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavingsView()
//    }
//}
