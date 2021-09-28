import UIKit

final class AnchorDimension: AnchorDimensionComposing {
    let anchor: NSLayoutDimension
    let type: AnchorType
    private(set) var root: AnchoringRoot
    
    init(anchor: NSLayoutDimension, root: AnchoringRoot, type: AnchorType) {
        self.anchor = anchor
        self.type = type
        self.root = root
        self.root.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func equalTo(_ otherConstraint: AnchorDimension,
                 multiplier: CGFloat = 1.0,
                 constant: CGFloat = 0.0,
                 priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(equalTo: otherConstraint.anchor,
                                           multiplier: multiplier,
                                           constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func lessThanOrEqualTo(_ otherConstraint: AnchorDimension,
                           multiplier: CGFloat = 1.0,
                           constant: CGFloat = 0.0,
                           priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherConstraint.anchor,
                                           multiplier: multiplier,
                                           constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func greaterThanOrEqualTo(_ otherConstraint: AnchorDimension,
                              multiplier: CGFloat = 1.0,
                              constant: CGFloat = 0.0,
                              priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherConstraint.anchor,
                                           multiplier: multiplier,
                                           constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func equalTo(constant: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func lessThanOrEqualTo(constant: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func greaterThanOrEqualTo(constant: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func equalToSuperview(multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let superview = root.superview else { return }
        equalTo(superview, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    func lessThanOrEqualToSuperview(multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let superview = root.superview else { return }
        lessThanOrEqualTo(superview, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    func greaterThanOrEqualToSuperview(multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let superview = root.superview else { return }
        greaterThanOrEqualTo(superview, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    func equalTo(_ root: AnchoringRoot, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let anchor = anchorFor(root: root) else { return }
        equalTo(anchor, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    func lessThanOrEqualTo(_ root: AnchoringRoot, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let anchor = anchorFor(root: root) else { return }
        lessThanOrEqualTo(anchor, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    func greaterThanOrEqualTo(_ root: AnchoringRoot, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let anchor = anchorFor(root: root) else { return }
        greaterThanOrEqualTo(anchor, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    private func anchorFor(root: AnchoringRoot?) -> AnchorDimension? {
        switch type {
        case .width:
            return root?.width
        case .height:
            return root?.height
        default:
            return nil
        }
    }
}
