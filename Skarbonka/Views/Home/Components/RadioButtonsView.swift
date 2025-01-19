import SwiftUI

struct RadioButtonPickerView: View {
    let options: [String]
    @Binding var selectedOption: String

    @EnvironmentObject private var style: StyleConfig

    var body: some View {
        ForEach(options, id: \.self) { option in
            Button(action: {
                withAnimation(.easeInOut(duration: 0.1)) {
                    selectedOption = option
                }
            }) {
                HStack {
                    Image(systemName: selectedOption == option ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(style.theme.primary)
                    Text(option).font(.body)
                }
                .foregroundStyle(.white)
                .padding(.vertical, 3)
            }
        }
    }
}
