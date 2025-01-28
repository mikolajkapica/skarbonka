import SwiftUI

// MARK: - Theme Configuration
struct ThemeConfig {
    // MARK: - Properties
    let primary: Color
    let gray: Color
    let foreground: Color
    let foregroundMuted: Color
    let background: Color
    let backgroundGradient: LinearGradient
    
    // MARK: - Initialization
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
        self.backgroundGradient = Self.createGradient(from: background)
    }
}

// MARK: - Private Methods
private extension ThemeConfig {
    static func createGradient(from color: Color) -> LinearGradient {
        LinearGradient(
            stops: [
                .init(color: color, location: 0.00),
                .init(
                    color: color.mix(with: .black, by: 0.2),
                    location: 1.00
                ),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Button Styles
struct FilledButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding(.horizontal, 12)
            .background(config.theme.primary)
            .foregroundColor(config.theme.foreground)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct MutedButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(config.theme.foregroundMuted)
            .foregroundColor(config.theme.gray)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct BorderButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.clear)
            .foregroundColor(config.theme.primary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(config.theme.primary, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct NoneButton: ButtonStyle {
    @EnvironmentObject private var config: StyleConfig
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.clear)
            .foregroundColor(config.theme.primary)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}
