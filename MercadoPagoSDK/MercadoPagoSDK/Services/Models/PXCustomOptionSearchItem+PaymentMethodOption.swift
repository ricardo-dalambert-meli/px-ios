import UIKit

extension PXCustomOptionSearchItem: PaymentMethodOption {
    func getId() -> String {
        return self.id
    }

    func hasChildren() -> Bool {
        return false
    }

    func getChildren() -> [PaymentMethodOption]? {
        return nil
    }

    func isCard() -> Bool {
        return false
    }

    func isCustomerPaymentMethod() -> Bool {
        return true
    }

    func getPaymentType() -> String {
        return self.paymentTypeId ?? self.id
    }
}
