import SwiftUI

struct DatePickerCard: View {
    // MARK: - Properties
    @State private var selectedDate: Date = Date()
    @EnvironmentObject private var style: StyleConfig
    
    // MARK: - Body
    var body: some View {
        DatePicker(
            String(localized: "Select Date"),
            selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
        .background(backgroundShape)
        .accentColor(style.theme.primary)
        .environment(\.locale, Locale(identifier: "pl"))
    }
}

// MARK: - Components
private extension DatePickerCard {
    var backgroundShape: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(radius: 5)
    }
}

// MARK: - Preview
#Preview {
    DatePickerCard()
        .environmentObject(StyleConfig())
} 