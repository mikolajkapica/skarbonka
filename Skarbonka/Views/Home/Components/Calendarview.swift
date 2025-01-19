import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date = Date()  // Default selected date is today
    @EnvironmentObject private var style: StyleConfig
    let today = Date()  // Store today's date for comparison

    var body: some View {
        DatePicker(
            "Select Date", selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())  // Graphical calendar style
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .accentColor(style.theme.primary)
        .environment(\.locale, Locale.init(identifier: "pl"))
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pl_PL")
        return formatter
    }
}

#Preview {
    CalendarView()
        .environmentObject(StyleConfig())

}
