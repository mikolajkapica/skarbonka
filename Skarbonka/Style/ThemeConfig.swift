import SwiftUI

struct ThemeConfig {
    var primary: Color
    var gray: Color
    var foreground: Color
    var foregroundMuted: Color
    var background: Color
    let backgroundGradient: LinearGradient
    
    init(
        primary: Color,
        gray: Color,
        foreground: Color,
        foregroundMuted: Color,
        background: Color
    ) {
        self.primary = primary
        self.gray = gray
        self.foreground = foreground
        self.foregroundMuted = foregroundMuted
        self.background = background
        self.backgroundGradient = LinearGradient(
            stops: [
                Gradient.Stop(
                    color: background,
                    location: 0.00
                ),
                Gradient.Stop(
                    color: background.mix(with: .black, by: 0.2),
                    location: 1.00
                ),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct FilledButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = self.config.theme.primary
        let foregroundColor = self.config.theme.foreground
        configuration.label
            .padding()
            .padding(.horizontal, 12)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct MutedButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = self.config.theme.foregroundMuted
        let foregroundColor = self.config.theme.gray
        return configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct BorderButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = self.config.theme.primary
        let foregroundColor = self.config.theme.primary
        return configuration.label
            .padding()
            .background(Color.clear)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(backgroundColor, lineWidth: 2))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct NoneButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    func makeBody(configuration: Configuration) -> some View {
        let foregroundColor = self.config.theme.primary
        return configuration.label
            .padding()
            .background(Color.clear)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}
