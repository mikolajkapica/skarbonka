import SwiftUI

import SwiftUI

struct Custom {
}

enum SkarbonkaTextSize {
    case xxxl
    case xxl
    case xl
    case l
    case ml
    case m
    case s
    case xs
    
    var fontSize: Font {
        switch self {
        case .xxxl: Font.system(size: 64)
        case .xxl: Font.system(size: 48)
        case .xl: Font.system(size: 40)
        case .l: Font.system(size: 32)
        case .ml: Font.system(size: 26)
        case .m: Font.system(size: 24)
        case .s: Font.system(size: 20)
        case .xs: Font.system(size: 16)
        }
    }
}

extension Text {
    func withSize(_ textSize: SkarbonkaTextSize) -> some View {
        return self.font(textSize.fontSize).kerning(0.5)
    }
}


enum SkarbonkaButtonStyleEnum {
    case filled
    case muted
    case border
    case none
    
    var backgroundColor: Color {
        switch self {
        case .filled: SkarbonkaColors.Orange
        case .muted: SkarbonkaColors.Orange
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

struct SkarbonkaColors {
    static let Orange = Color(red: 1, green: 0.38, blue: 0)
    static let white = Color(red: 1, green: 0.92, blue: 0.87)
    static let black = Color.black
    static let PurpleGradient = LinearGradient(
        stops: [
        Gradient.Stop(color: Color(red: 0.57, green: 0.3, blue: 0.68), location: 0.00),
        Gradient.Stop(color: Color(red: 0.16, green: 0.17, blue: 0.32), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
        )
    
}


extension NavigationLink {
    func style(_ style: SkarbonkaButtonStyleEnum) -> some View {
        self.buttonStyle(SkarbonkaButtonStyle(style: .filled))
    }
}

struct SkarbonkaButtonStyle: ButtonStyle {
    let style: SkarbonkaButtonStyleEnum
    let weight: Font.Weight = Font.Weight.bold
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(style.backgroundColor)
            .cornerRadius(.infinity)
            .foregroundStyle(.white)
            .fontWeight(weight)
    }
}

