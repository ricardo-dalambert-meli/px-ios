import Foundation

extension NSMutableAttributedString {
    func appendWithSpace(_ string: NSAttributedString) {
        self.append(" ".toAttributedString())
        self.append(string)
    }
}
