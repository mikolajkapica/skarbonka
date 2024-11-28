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
    func withSize(_ textSize: TextSize) -> some View {
        return self.font(textSize.fontSize)
    }
}


enum SkarbonkaButtonStyleEnum {
    case filled
    case muted
    case border
    case none
    
    var backgroundColor: Color {
        switch self {
        case .filled: .orange
        case .muted: .orange.mix(with: Color.gray, by: 0.3)
        case .border: .clear
        case .none: .clear
        }
    }
    
    var border: some View {
        switch self {
        case .filled: AnyView(EmptyView())
        case .muted: AnyView(EmptyView())
        case .border: AnyView(RoundedRectangle(cornerRadius: .infinity).stroke(Color.white, lineWidth: 2))
        case .none: AnyView(EmptyView())
        }
    }
}


extension NavigationLink {
    func style(_ style: SkarbonkaButtonStyleEnum) -> some View {
        self.buttonStyle(SkarbonkaButtonStyle(style: .filled))
    }
}

struct SkarbonkaButtonStyle: ButtonStyle {
    let style: SkarbonkaButtonStyleEnum
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(style.backgroundColor)
            .foregroundStyle(.white)
            .cornerRadius(.infinity)
            .overlay(style.border)
    }
}

