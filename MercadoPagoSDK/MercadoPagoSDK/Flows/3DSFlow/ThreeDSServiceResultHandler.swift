import Foundation

internal protocol ThreeDSServiceResultHandler: NSObjectProtocol {
    func finishFlow(threeDSAuthorization: Bool)
    func finishWithError(error: MPSDKError)
}
