import Foundation

final class PXFooterView: UIView {
    weak var delegate: PXFooterTrackingProtocol?
    public var principalButton: PXAnimatedButton?
    public var linkButton: UIControl?
}
