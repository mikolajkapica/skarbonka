import SwiftUI

struct RadioButtonPickerView: View {
    // MARK: - Properties
    let options: [String]
    @Binding var selectedOption: String
    @EnvironmentObject private var style: StyleConfig
    
    // MARK: - Body
    var body: some View {
        ForEach(options, id: \.self) { option in
            radioButton(for: option)
        }
    }
}

// MARK: - Components
private extension RadioButtonPickerView {
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
    
    func selectOption(_ option: String) {
        withAnimation(.easeInOut(duration: 0.1)) {
            selectedOption = option
        }
    }
}
