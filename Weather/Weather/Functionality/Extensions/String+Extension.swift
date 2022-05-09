
import Foundation

// MARK: - Static strings
extension String {
    static let degree = "°"
    static let empty = ""
    static let slash = "/"
    static let dash = "_"
    static let space = " "
}

// MARK: - Static strings
extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: String.empty)
    }
}

// MARK: - Suscripts
extension String {
    subscript (range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(self.count, range.lowerBound)),
                                            upper: min(self.count, max(0, range.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

