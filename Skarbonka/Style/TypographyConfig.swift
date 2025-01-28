import SwiftUI

// MARK: - Typography Configuration
struct TypographyConfig {
    // MARK: - Properties
    let xxxl: Font
    let xxl: Font
    let xl: Font
    let l: Font
    let ml: Font
    let m: Font
    let s: Font
    let xs: Font
    let fontDesign: Font.Design
}

// MARK: - Font Helpers
extension TypographyConfig {
    func customFont(size: CGFloat) -> Font {
        .system(size: size, design: fontDesign)
    }
}
