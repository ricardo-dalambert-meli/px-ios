import Foundation

extension String {
    var firstCapitalized: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
