import Foundation

struct PXOneTapHeaderMerchantLayout {
    enum LayoutType {
        case onlyTitle
        case titleSubtitle
    }

    private let layoutType: LayoutType
    private var horizontalLayoutConstraints: [NSLayoutConstraint] = []
    private var verticalLayoutConstraints: [NSLayoutConstraint] = []
    
    private let showHorizontally: Bool

    internal let IMAGE_NAV_SIZE: CGFloat = 40
    internal var IMAGE_SIZE: CGFloat {
        if showHorizontally {
            return 40
        } else {
            // Define device size
            let deviceSize = PXDeviceSize.getDeviceSize(deviceHeight: UIScreen.main.bounds.height)
            
            switch deviceSize {
                case .small:
                    return 48
                case .regular:
                    return 48
                case .large:
                    return 55
                case .extraLarge:
                    return 65
            }
        }
    }

    init(layoutType: PXOneTapHeaderMerchantLayout.LayoutType, showHorizontally: Bool = false) {
        self.layoutType = layoutType
        self.showHorizontally = showHorizontally
    }
}

// MARK: Publics
extension PXOneTapHeaderMerchantLayout {
    func getLayoutType() -> LayoutType {
        return layoutType
    }
}
