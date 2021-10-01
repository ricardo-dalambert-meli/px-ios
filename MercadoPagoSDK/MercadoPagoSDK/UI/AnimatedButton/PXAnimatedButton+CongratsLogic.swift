import Foundation

extension PXAnimatedButton {
    static func animateButtonWith(status: String, statusDetail: String? = nil) {
        PXNotificationManager.Post.animateButton(with: PXAnimatedButtonNotificationObject(status: status, statusDetail: statusDetail))
    }
}
