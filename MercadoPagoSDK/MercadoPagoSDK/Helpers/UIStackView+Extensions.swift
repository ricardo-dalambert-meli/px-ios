import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview(view)
        }
    }
}
