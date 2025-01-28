import SwiftUI

struct FormField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let error: String?
    var keyboardType: UIKeyboardType = .default
    let onTextChange: (String) -> Void
    
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
                .background(Color(.systemGray6))
                .cornerRadius(.infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(
                            error == nil ? Color.clear : Color.red,
                            lineWidth: 2
                        )
                )
            
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
} 