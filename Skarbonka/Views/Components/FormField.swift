import SwiftUI

struct FormField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let error: String?
    var keyboardType: UIKeyboardType = .default
    let onTextChange: (String) -> Void

    let cornerRadius: CGFloat = 10

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            TextField(placeholder, text: $text)
                .onChange(of: text) { _, newValue in
                    onTextChange(newValue)
                }
                .keyboardType(keyboardType)
                .padding()
                .background(Color(.white))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            error == nil ? Color.clear : Color.red,
                            lineWidth: 2
                        )
                )
            
            if let error = error {
                Text(error)
                    .padding(.leading, 10)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
} 

#Preview {
    FormField(title: "Title", placeholder: "Placeholder", text: .constant(""), error: "gdsih", onTextChange: { _ in })
}
