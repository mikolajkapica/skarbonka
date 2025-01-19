import SwiftUI

struct RadioButtonPickerView: View {
    @Binding var selectedOption: String?

    @EnvironmentObject private var style: StyleConfig

    let options: [String]

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
