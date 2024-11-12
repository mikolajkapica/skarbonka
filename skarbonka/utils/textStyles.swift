import SwiftUI

import SwiftUI

struct Custom {
}

enum TextSize {
    case xxl
    case xl
    case l
    case ml
    case m
    case s
    case xs
    
    var fontSize: Font {
        switch self {
        case .xxl: Font.system(size: 48, weight: .bold, design: .default)
        case .xl: Font.system(size: 40, weight: .semibold, design: .default)
        case .l: Font.system(size: 32, weight: .medium, design: .default)
        case .ml: Font.system(size: 28, weight: .regular, design: .default)
        case .m: Font.system(size: 24, weight: .regular, design: .default)
        case .s: Font.system(size: 20, weight: .regular, design: .default)
        case .xs: Font.system(size: 16, weight: .regular, design: .default)
        }
    }
}

extension Text {
    func withSize(_ style: TextSize) -> some View {
        return self.font(style.fontSize)
    }
}


enum ButtonStyle {
    case filled
    case muted
    case border
    
    var backgroundColor: Color {
        switch self {
        case .filled: .orange
        case .muted: .orange.mix(with: Color.gray, by: 0.3)
        case .border: .clear
        }
    }
}

struct BorderModifier: ViewModifier {
    var borderStyle: ButtonStyle
    var borderColor: Color = .orange // Default border color
    var borderWidth: CGFloat = 2 // Default border width
    
    private func getBorder() -> some View {
        switch style {
        case .filled:
            return AnyView(EmptyView()) // No border for the 'filled' style
        case .muted:
            return AnyView(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
        case .border:
            return AnyView(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
        }
    }
    
    func body(content: Content) -> some View {
        switch borderStyle {
        case .filled: AnyView(content)
        case .muted: AnyView(content)
        case .border: AnyView(content).overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 2)
            )
        }
    }
}

extension Button {
    func style(_ style: ButtonStyle) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(.orange)
            .foregroundStyle(.white)
            .cornerRadius(100)
            .borde
            .padding()
    }
}

