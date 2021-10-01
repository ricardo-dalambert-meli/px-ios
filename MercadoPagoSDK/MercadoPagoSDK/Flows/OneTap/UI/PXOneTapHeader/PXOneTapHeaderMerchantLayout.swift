import Foundation

struct PXOneTapHeaderMerchantLayout {
    enum LayoutType {
        case onlyTitle
        case titleSubtitle
    }

    private let layoutType: LayoutType
    private var horizontalLayoutConstraints: [NSLayoutConstraint] = []
    private var verticalLayoutConstraints: [NSLayoutConstraint] = []

    internal let IMAGE_NAV_SIZE: CGFloat = 40
    internal var IMAGE_SIZE: CGFloat {
        if UIDevice.isSmallDevice() {
            return IMAGE_NAV_SIZE
        } else if UIDevice.isLargeDevice() || UIDevice.isExtraLargeDevice() {
            return 65
        } else {
            return 55
        }
    }

    init(layoutType: PXOneTapHeaderMerchantLayout.LayoutType) {
        self.layoutType = layoutType
    }
}

// MARK: Publics
extension PXOneTapHeaderMerchantLayout {
    func getLayoutType() -> LayoutType {
        return layoutType
    }
}
