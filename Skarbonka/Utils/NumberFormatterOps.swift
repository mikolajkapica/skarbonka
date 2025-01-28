import Foundation

// MARK: - NumberFormatter Extensions
extension NumberFormatter {
    /// Currency formatter with no decimal places
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal  // Use .currency if formatting with currency symbols
        formatter.maximumFractionDigits = 0
        return formatter
    }
}
