import SwiftUI

struct RadioButtonPickerView: View {
    @Binding var selectedOption: Optional<String>
    let options: [String]

    var body: some View {
        ForEach(options, id: \.self) { option in
            Button(action: {
                selectedOption = Optional.some(option)
            }) {
                HStack {
                    Image(
                        systemName: selectedOption == option
                            ? "largecircle.fill.circle" : "circle"
                    )
                    .foregroundColor(SkarbonkaColors.Orange)
                    Text(option).font(.body)
                }
                .foregroundStyle(.white)
            }
        }
    }
}
