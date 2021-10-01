import UIKit

class PXUIImage: UIImage {
    var url: String?
    var placeholder: String?
    var fallback: String?

    convenience init(url: String?, placeholder: String? = nil, fallback: String? = nil) {
        self.init()
        self.url = url
        self.placeholder = placeholder
        self.fallback = fallback
    }
}
