import SwiftUI

struct IconSelectionGrid: View {
    @Binding var selectedIcon: String
    let icons: [String]
    let style: StyleConfig
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "Wybierz grafikę"))
                .font(.headline)
                .foregroundColor(.white)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ], spacing: 16
            ) {
                ForEach(icons, id: \.self) { icon in
                    IconButton(
                        icon: icon,
                        isSelected: selectedIcon == icon,
                        style: style
                    ) {
                        selectedIcon = icon
                    }
                }
            }
        }
    }
}

private struct IconButton: View {
    let icon: String
    let isSelected: Bool
    let style: StyleConfig
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(
                    isSelected ? style.theme.primary : style.theme.background
                )
                .font(.system(size: 40))
                .frame(width: 100, height: 100)
                .background(style.theme.foreground)
                .clipShape(Circle())
        }
    }
} 