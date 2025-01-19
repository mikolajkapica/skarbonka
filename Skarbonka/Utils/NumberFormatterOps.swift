import SwiftUI

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal  // Use .currency if formatting with currency symbols
        formatter.maximumFractionDigits = 0
        return formatter
    }
}
