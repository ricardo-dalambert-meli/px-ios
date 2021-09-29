import UIKit

protocol AnchorDimensionComposing {
    var root: AnchoringRoot { get }
    var type: AnchorType { get }
    func equalTo(_ root: AnchoringRoot, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority)
    func lessThanOrEqualTo(_ root: AnchoringRoot, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority)
    func greaterThanOrEqualTo(_ root: AnchoringRoot, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority)
    func equalTo(constant: CGFloat, priority: UILayoutPriority)
    func lessThanOrEqualTo(constant: CGFloat, priority: UILayoutPriority)
    func greaterThanOrEqualTo(constant: CGFloat, priority: UILayoutPriority)
}

extension AnchorDimensionComposing {
    var width: ComposedDimensionAnchor { .init(root: root, anchors: [self, root.width]) }
    var height: ComposedDimensionAnchor { .init(root: root, anchors: [self, root.height]) }
}
