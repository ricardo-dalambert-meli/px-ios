import Foundation

@objc internal protocol PXComponentizable {
    func render() -> UIView
    @objc optional func oneTapRender() -> UIView
}

internal protocol PXXibComponentizable {
    func xibName() -> String
    func containerView() -> UIView
    func renderXib() -> UIView
}
