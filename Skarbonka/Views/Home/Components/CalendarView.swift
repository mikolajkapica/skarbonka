import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date = Date()
    
    @EnvironmentObject private var style: StyleConfig
    
    var body: some View {
        DatePicker(
            "Select Date", selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
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
