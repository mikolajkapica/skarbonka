import SwiftUI

struct RadioButtonPicker: View {
    // MARK: - Properties
    @EnvironmentObject private var style: StyleConfig
    @Binding var selectedOption: String
    let options: [String]
    
    // MARK: - Body
    var body: some View {
        ForEach(options, id: \.self) { option in
            radioButton(for: option)
        }
    }
}

// MARK: - Components
private extension RadioButtonPicker {
    func radioButton(for option: String) -> some View {
        Button(action: { selectOption(option) }) {
            HStack {
                radioIcon(isSelected: selectedOption == option)
                Text(option).font(.body)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 3)
        }
    }
    
    func radioIcon(isSelected: Bool) -> some View {
        Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
            .foregroundColor(style.theme.primary)
    }
}

// MARK: - Actions
private extension RadioButtonPicker {
    func selectOption(_ option: String) {
        withAnimation(.easeInOut(duration: 0.1)) {
            selectedOption = option
        }
    }
}

// MARK: - Preview
#Preview {
    RadioButtonPicker(
        selectedOption: .constant("Option 1"),
        options: ["Option 1", "Option 2", "Option 3"]
    )
    .environmentObject(StyleConfig())
} 