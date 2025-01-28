import Foundation
import Swift
import SwiftUI

struct SavingsView: View {
    // MARK: - Properties
    let savePerFrequencyBinding: Binding<Double>
    let calculatedDays: Int
    @EnvironmentObject private var style: StyleConfig
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleText
            sliderView
            amountInput
            daysCalculationText
        }
    }
}

// MARK: - Components
private extension SavingsView {
    var titleText: some View {
        Text(String(localized: "Jaką kwotę będziesz oszczędzać?"))
            .font(.headline)
            .foregroundStyle(.white)
    }
    
    var sliderView: some View {
        Slider(
            value: savePerFrequencyBinding,
            in: 1...50,
            step: 1
        )
        .accentColor(style.theme.primary)
    }
    
    var amountInput: some View {
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
    }
    
    var daysCalculationText: some View {
        Text(daysMessage)
            .font(.subheadline)
            .foregroundStyle(.white)
    }
    
    var daysMessage: String {
        "\(String(localized: "Kupisz za")) \(calculatedDays) \(String(localized: "dni"))"
    }
}

// MARK: - Preview
#Preview {
    SavingsView(
        savePerFrequencyBinding: .constant(10),
        calculatedDays: 10
    )
    .environmentObject(StyleConfig())
}
