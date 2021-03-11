//
//  PXCardSliderApplicationData.swift
//  MercadoPagoSDKV4
//
//  Created by Jonathan Scaramal on 09/03/2021.
//

import MLCardDrawer

final class PXCardSliderApplicationData {
    internal init(paymentMethodId: String, paymentTypeId: String?, shouldShowArrow: Bool, cardData: CardData? = nil, selectedPayerCost: PXPayerCost? = nil, payerCost: [PXPayerCost] = [PXPayerCost](), displayMessage: NSAttributedString? = nil, amountConfiguration: PXAmountConfiguration? = nil, status: PXStatus, bottomMessage: PXCardBottomMessage? = nil, benefits: PXBenefits? = nil, behaviours: [String : PXBehaviour]? = nil, displayInfo: PXOneTapDisplayInfo? = nil, userDidSelectPayerCost: Bool = false, payerPaymentMethod: PXCustomOptionSearchItem? = nil) {
        self.paymentMethodId = paymentMethodId
        self.paymentTypeId = paymentTypeId
        self.shouldShowArrow = shouldShowArrow
        self.cardData = cardData
        self.selectedPayerCost = selectedPayerCost
        self.payerCost = payerCost
        self.displayMessage = displayMessage
        self.amountConfiguration = amountConfiguration
        self.status = status
        self.bottomMessage = bottomMessage
        self.benefits = benefits
        self.behaviours = behaviours
        self.displayInfo = displayInfo
        self.userDidSelectPayerCost = userDidSelectPayerCost
        self.payerPaymentMethod = payerPaymentMethod
    }

    var paymentMethodId: String?
    var paymentTypeId: String?
    var shouldShowArrow: Bool
    var cardData: CardData?
    var selectedPayerCost: PXPayerCost?
    var payerCost: [PXPayerCost] = [PXPayerCost]()
    var displayMessage: NSAttributedString?
    var amountConfiguration: PXAmountConfiguration?
    var status: PXStatus
    var bottomMessage: PXCardBottomMessage?
    var benefits: PXBenefits?
    var behaviours: [String: PXBehaviour]?
    var displayInfo: PXOneTapDisplayInfo?
    var userDidSelectPayerCost: Bool = false
    var payerPaymentMethod: PXCustomOptionSearchItem?

}
