import Foundation

protocol PXOneTapInstallmentInfoViewProtocol: NSObjectProtocol {
    func hideInstallments()
    func showInstallments(installmentData: PXInstallment?, selectedPayerCost: PXPayerCost?, interest: PXInstallmentsConfiguration?, reimbursement: PXInstallmentsConfiguration?)
    func cardTapped(status: PXStatus)
}
