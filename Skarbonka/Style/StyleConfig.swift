import SwiftUI

private let themeConfig = ThemeConfig(
    primary: Color(red: 1, green: 0.38, blue: 0),
    gray: Color(red: 0.28, green: 0.27, blue: 0.31),
    foreground: Color(red: 1, green: 0.92, blue: 0.87),
    foregroundMuted: Color(red: 1, green: 0.87, blue: 0.80),
    background: Color(red: 0.57, green: 0.3, blue: 0.68)
)

private let typographyConfig = TypographyConfig(
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

class StyleConfig: ObservableObject {
    @Published var theme: ThemeConfig
    @Published var typography: TypographyConfig
    
    init(theme: ThemeConfig = themeConfig, typography: TypographyConfig = typographyConfig) {
        self.theme = theme
        self.typography = typography
    }
}

