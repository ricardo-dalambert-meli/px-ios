import UIKit

@objcMembers
internal class PXNavigationHeaderLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        if self.font != nil {
            self.font = Utils.getFont(size: self.font!.pointSize)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.font != nil {
            self.font = Utils.getFont(size: self.font!.pointSize)
        }
    }
}

internal class PXToolbar: UIToolbar {}
