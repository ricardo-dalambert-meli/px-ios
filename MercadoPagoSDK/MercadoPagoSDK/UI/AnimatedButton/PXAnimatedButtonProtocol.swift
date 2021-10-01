import Foundation
protocol PXAnimatedButtonDelegate: NSObjectProtocol {
    func expandAnimationInProgress()
    func didFinishAnimation()
    func progressButtonAnimationTimeOut()
    func shakeDidFinish()
}
