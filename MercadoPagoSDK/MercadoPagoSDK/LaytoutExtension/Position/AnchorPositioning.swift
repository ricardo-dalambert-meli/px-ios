import UIKit

protocol AnchorPositioning {
    var type: AnchorType { get }
    var root: AnchoringRoot { get }
    func equalTo(_ otherConstraint: Self, constant: CGFloat, priority: UILayoutPriority)
    func lessThanOrEqualTo(_ otherConstraint: Self, constant: CGFloat, priority: UILayoutPriority)
    func greaterThanOrEqualTo(_ otherConstraint: Self, constant: CGFloat, priority: UILayoutPriority)
}

extension AnchorPositioning {
    func equalToSuperview(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let superview = root.superview else { return }
        equalTo(superview, constant: constant, priority: priority)
    }
    
    func lessThanOrEqualToSuperview(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let superview = root.superview else { return }
        lessThanOrEqualTo(superview, constant: constant, priority: priority)
    }
    
    func greaterThanOrEqualToSuperview(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let superview = root.superview else { return }
        greaterThanOrEqualTo(superview, constant: constant, priority: priority)
    }
    
    func equalTo(_ root: AnchoringRoot, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let anchor = anchorFor(root: root) else { return }
        equalTo(anchor, constant: constant, priority: priority)
    }
    
    func lessThanOrEqualTo(_ root: AnchoringRoot, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let anchor = anchorFor(root: root) else { return }
        lessThanOrEqualTo(anchor, constant: constant, priority: priority)
    }
    
    func greaterThanOrEqualTo(_ root: AnchoringRoot, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let anchor = anchorFor(root: root) else { return }
        greaterThanOrEqualTo(anchor, constant: constant, priority: priority)
    }
    
    private func anchorFor(root: AnchoringRoot?) -> Self? {
        switch type {
        case .leading:
            return root?.leading as? Self
        case .trailing:
            return root?.trailing as? Self
        case .centerX:
            return root?.centerX as? Self
        case .top:
            return root?.top as? Self
        case .bottom:
            return root?.bottom as? Self
        case .centerY:
            return root?.centerY as? Self
        default:
            return nil
        }
    }
}
