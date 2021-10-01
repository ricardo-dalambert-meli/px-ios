import UIKit

class PXCloseLinkAction: PXAction {
    init() {
        super.init(label: PXFooterResultConstants.DEFAULT_LINK_TEXT.localized) {
            PXNotificationManager.Post.attemptToClose()
        }
    }
}
