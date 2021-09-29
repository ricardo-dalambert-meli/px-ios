import UIKit

protocol AnchorPositioningComposing {
    var root: AnchoringRoot { get }
    var type: AnchorType { get }
    func equalTo(_ view: AnchoringRoot, constant: CGFloat, priority: UILayoutPriority)
    func lessThanOrEqualTo(_ view: AnchoringRoot, constant: CGFloat, priority: UILayoutPriority)
    func greaterThanOrEqualTo(_ view: AnchoringRoot, constant: CGFloat, priority: UILayoutPriority)
}

extension AnchorPositioningComposing {
    var trailing: ComposedPositionAnchor { .init(root: root, anchors: [self, root.trailing]) }
    var leading: ComposedPositionAnchor { .init(root: root, anchors: [self, root.leading]) }
    var centerX: ComposedPositionAnchor { .init(root: root, anchors: [self, root.centerX]) }
    var top: ComposedPositionAnchor { .init(root: root, anchors: [self, root.top]) }
    var bottom: ComposedPositionAnchor { .init(root: root, anchors: [self, root.bottom]) }
    var centerY: ComposedPositionAnchor { .init(root: root, anchors: [self, root.centerY]) }
}
