import Foundation

// MARK: PaymentHandlerProtocol implementation
extension PXPaymentFlow: PaymentHandlerProtocol {
    func handlePayment(payment: PXPayment) {
        guard let paymentData = self.model.amountHelper?.getPaymentData() else {
            return
        }

        self.model.handleESCForPayment(status: payment.status, statusDetails: payment.statusDetail, errorPaymentType: paymentData.getPaymentMethod()?.paymentTypeId)

        if payment.getStatusDetail() == PXRejectedStatusDetail.INVALID_ESC.rawValue {
            self.paymentErrorHandler?.escError(reason: .ESC_CAP)
            return
        }

        let paymentResult = PaymentResult(payment: payment, paymentData: paymentData)
        self.model.paymentResult = paymentResult
        self.executeNextStep()
    }

    func handlePayment(business: PXBusinessResult) {
        self.model.businessResult = business
        self.model.handleESCForPayment(status: business.paymentStatus, statusDetails: business.paymentStatusDetail, errorPaymentType: self.model.amountHelper?.getPaymentData().getPaymentMethod()?.paymentTypeId)
        self.executeNextStep()
    }

    func handlePayment(basePayment: PXBasePayment) {
        if let business = basePayment as? PXBusinessResult {
            handlePayment(business: business)
        } else if let payment = basePayment as? PXPayment {
            handlePayment(basePayment: payment)
        } else {
            guard let paymentData = self.model.amountHelper?.getPaymentData() else {
                return
            }

            self.model.handleESCForPayment(status: basePayment.getStatus(), statusDetails: basePayment.getStatusDetail(), errorPaymentType: paymentData.getPaymentMethod()?.paymentTypeId)

            if basePayment.getStatusDetail() == PXRejectedStatusDetail.INVALID_ESC.rawValue {
                self.paymentErrorHandler?.escError(reason: .ESC_CAP)
                return
            }

            let paymentResult = PaymentResult(status: basePayment.getStatus(), statusDetail: basePayment.getStatusDetail(), paymentData: paymentData, splitAccountMoney: self.model.amountHelper?.splitAccountMoney, payerEmail: nil, paymentId: basePayment.getPaymentId(), statementDescription: nil, paymentMethodId: basePayment.getPaymentMethodId(), paymentMethodTypeId: basePayment.getPaymentMethodTypeId())
            self.model.paymentResult = paymentResult
            self.executeNextStep()
        }
    }
}
