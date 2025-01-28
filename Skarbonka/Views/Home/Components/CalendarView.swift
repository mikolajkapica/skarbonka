import SwiftUI

struct CalendarView: View {
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
private extension CalendarView {
    var backgroundShape: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(radius: 5)
    }
}

// MARK: - Preview
#Preview {
    CalendarView()
        .environmentObject(StyleConfig())
}
