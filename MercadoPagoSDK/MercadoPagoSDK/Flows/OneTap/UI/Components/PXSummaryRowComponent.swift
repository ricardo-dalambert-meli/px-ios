import Foundation

typealias PXSummaryRowProps = (title: String, subTitle: String?, rightText: String, backgroundColor: UIColor?)

final class PXSummaryRowComponent: NSObject, PXComponentizable {
    private var props: PXSummaryRowProps

    init(props: PXSummaryRowProps) {
        self.props = props
    }

    func render() -> UIView {
        return UIView()
    }

    func oneTapRender() -> UIView {
        return PXOneTapSummaryRowRenderer(withProps: props).renderXib()
    }
}
