import UIKit

internal class PXPaymentMethodIconComponent: PXComponentizable {
    var props: PXPaymentMethodIconProps

    init(props: PXPaymentMethodIconProps) {
        self.props = props
    }
    func render() -> UIView {
        return PXPaymentMethodIconRenderer().render(component: self)
    }
}

internal class PXPaymentMethodIconProps {
    var paymentMethodIcon: UIImage?

    init(paymentMethodIcon: UIImage?) {
        self.paymentMethodIcon = paymentMethodIcon
    }
}
