import Foundation

// MARK: Tracking
extension PXPaymentData {
    func getPaymentDataForTracking() -> [String: Any] {
        guard let paymentMethod = paymentMethod else {
            return [:]
        }

        let cardIdsEsc = PXTrackingStore.sharedInstance.getData(forKey: PXTrackingStore.cardIdsESC) as? [String] ?? []
        var properties: [String: Any] = [:]

        properties["payment_method_type"] = paymentMethod.getPaymentTypeForTracking()
        properties["payment_method_id"] = paymentMethod.getPaymentIdForTracking()
        var extraInfo: [String: Any] = [:]
        if paymentMethod.isCard {
            if let cardId = token?.cardId {
                extraInfo["card_id"] = cardId
                extraInfo["has_esc"] = cardIdsEsc.contains(cardId)
            }
            extraInfo["selected_installment"] = payerCost?.getPayerCostForTracking()
            if let issuerId = issuer?.id {
                extraInfo["issuer_id"] = Int64(issuerId)
            }
            properties["extra_info"] = extraInfo
        } else if paymentMethod.isAccountMoney {
            // TODO: When account money becomes FCM
            // var extraInfo: [String: Any] = [:]
            // extraInfo["balance"] =
            // properties["extra_info"] = extraInfo
        } else if paymentMethod.isDigitalCurrency {
            extraInfo["selected_installment"] = payerCost?.getPayerCostForTracking(isDigitalCurrency: true)
            properties["extra_info"] = extraInfo
        }
        return properties
    }
}
