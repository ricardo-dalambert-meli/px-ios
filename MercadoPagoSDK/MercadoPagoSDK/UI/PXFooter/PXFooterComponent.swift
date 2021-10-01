import UIKit

class PXFooterComponent: NSObject, PXComponentizable {
    var props: PXFooterProps

    init(props: PXFooterProps) {
        self.props = props
    }

    func render() -> UIView {
        return PXFooterRenderer().render(self)
    }

    func oneTapRender() -> UIView {
        return PXFooterRenderer().oneTapRender(self)
    }
}
