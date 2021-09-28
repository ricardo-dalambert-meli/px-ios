import UIKit

final class AnchorY: AnchorPositioning, AnchorPositioningComposing {    
    let anchor: NSLayoutYAxisAnchor
    let type: AnchorType
    private(set) var root: AnchoringRoot
    
    init(anchor: NSLayoutYAxisAnchor, root: AnchoringRoot, type: AnchorType) {
        self.anchor = anchor
        self.type = type
        self.root = root
        self.root.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func equalTo(_ otherConstraint: AnchorY, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(equalTo: otherConstraint.anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func lessThanOrEqualTo(_ otherConstraint: AnchorY, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherConstraint.anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func greaterThanOrEqualTo(_ otherConstraint: AnchorY, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherConstraint.anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
}
