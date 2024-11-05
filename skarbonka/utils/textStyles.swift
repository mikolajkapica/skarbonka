import SwiftUI

struct Custom {
    public static let largeTitle = Font.system(size: 80, weight: .bold, design: .default)
    public static let title = Font.system(size: 64, weight: .semibold, design: .default)
    public static let headline = Font.system(size: 48, weight: .medium, design: .default)
    public static let subheadline = Font.system(size: 32, weight: .regular, design: .default)
    public static let body = Font.system(size: 24, weight: .regular, design: .default)
    public static let footnote = Font.system(size: 16, weight: .regular, design: .default)
    public static let caption = Font.system(size: 12, weight: .regular, design: .default)
    
    func withSize(size: CGFloat) -> Font {
        Font.system(size: size)
    }
}
