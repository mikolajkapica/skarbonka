import Foundation
import Swift
import SwiftUI

struct SavingsView: View {
    let savePerFrequencyBinding: Binding<Double>
    let calculatedDays: Int
    @EnvironmentObject var style: StyleConfig

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(String(localized: "Jaką kwotę będziesz oszczędzać?"))
                .font(.headline)
                .foregroundStyle(.white)

            Slider(
                value: savePerFrequencyBinding,
                in: 1...50,
                step: 1
            )
            .accentColor(style.theme.primary)

            TextField(
                String(localized: "Kwota"),
                value: savePerFrequencyBinding,
                formatter: NumberFormatter.currency
            )
            .keyboardType(.numberPad)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .font(.title3)
            .bold()

            Text(
                "\(String(localized: "Kupisz za")) \(calculatedDays) \(String(localized: "dni"))"
            )
            .font(.subheadline)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    SavingsView(
        savePerFrequencyBinding: .constant(10),
        calculatedDays: 10
    ).environmentObject(StyleConfig())
}
