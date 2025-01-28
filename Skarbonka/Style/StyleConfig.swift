import SwiftUI

// MARK: - Style Configuration
class StyleConfig: ObservableObject {
    // MARK: - Published Properties
    @Published var theme: ThemeConfig
    @Published var typography: TypographyConfig
    
    // MARK: - Initialization
    init(
        theme: ThemeConfig = defaultTheme,
        typography: TypographyConfig = defaultTypography
    ) {
        self.theme = theme
        self.typography = typography
    }
    
    // MARK: - Default Values
    static let defaultTheme = ThemeConfig(
        primary: Color(red: 1, green: 0.38, blue: 0),
        gray: Color(red: 0.28, green: 0.27, blue: 0.31),
        foreground: Color(red: 1, green: 0.92, blue: 0.87),
        foregroundMuted: Color(red: 1, green: 0.87, blue: 0.80),
        background: Color(red: 0.57, green: 0.3, blue: 0.68)
    )
    
    static let defaultTypography = TypographyConfig(
        xxxl: .system(size: 64),
        xxl: .system(size: 48),
        xl: .system(size: 40),
        l: .system(size: 32),
        ml: .system(size: 26),
        m: .system(size: 24),
        s: .system(size: 16),
        xs: .system(size: 16),
        fontDesign: .rounded
    )
}

// MARK: - Preview Helpers
#if DEBUG
extension StyleConfig {
    static var preview: StyleConfig {
        StyleConfig()
    }
}
#endif

