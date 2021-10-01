import Foundation
extension MercadoPagoCheckout: PXPaymentErrorHandlerProtocol {
    func escError(reason: PXESCDeleteReason) {
        viewModel.invalidESCReason = reason
        viewModel.prepareForInvalidPaymentWithESC(reason: reason)
        executeNextStep()
    }
}
