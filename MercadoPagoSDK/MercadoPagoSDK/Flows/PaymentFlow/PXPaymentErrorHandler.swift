import Foundation

@objc internal protocol PXPaymentErrorHandlerProtocol: NSObjectProtocol {
    func escError(reason: PXESCDeleteReason)
    func exitCheckout()
}
