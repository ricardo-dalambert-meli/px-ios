//
//  PXCardSliderViewModel.swift
//  MercadoPagoSDK
//
//  Created by Juan sebastian Sanzone on 31/10/18.
//

import UIKit
import MLCardDrawer

typealias PXApplicationId = String

final class PXCardSliderViewModel {
    
    let issuerId: String
    let cardUI: CardUI
    var cardId: String?
    
    var accountMoneyBalance: Double?
    
    let creditsViewModel: PXCreditsViewModel?
    
    var isCredits: Bool {
        return self.paymentMethodId == PXPaymentTypes.CONSUMER_CREDITS.rawValue
    }
    
    // Values mapped with applications
    var paymentMethodId: String? {
        get {
            if let selectedApplication = selectedApplication, let applicationsData = applicationsData {
                return applicationsData[selectedApplication]?.paymentMethodId ?? nil
            }
        }
        set {
            if let selectedApplication = selectedApplication, let applicationsData = applicationsData {
                applicationsData[selectedApplication]?.paymentMethodId = newValue ?? nil
            }
        }
    }
    
    let paymentTypeId: String?
    var shouldShowArrow: Bool
    var cardData: CardData?
    var selectedPayerCost: PXPayerCost?
    var payerCost: [PXPayerCost] = [PXPayerCost]()
    var displayMessage: NSAttributedString?
    var amountConfiguration: PXAmountConfiguration?
    let status: PXStatus
    var bottomMessage: PXCardBottomMessage?
    var benefits: PXBenefits?
    var behaviours: [String: PXBehaviour]?
    var displayInfo: PXOneTapDisplayInfo?
    var userDidSelectPayerCost: Bool = false
    var payerPaymentMethod: PXCustomOptionSearchItem?
    
    var applicationsData : [PXApplicationId: PXCardSliderApplicationData]?
    
    var selectedApplication : PXApplicationId?
    
//    let payerPaymentMethods: [PXCustomOptionSearchItem]?
//    var payerPaymentMethod: PXCustomOptionSearchItem? {
//        guard let payerPaymentMethods = payerPaymentMethods,
//              payerPaymentMethods.count > 0 else { return nil }
//        var customOptionSearchItem = payerPaymentMethods[0]
//        if payerPaymentMethods.count > 1,
//           let selectedPaymentMethodTypeId = selectedPaymentMethodTypeId {
//            if let selectedPaymentMethod = payerPaymentMethods.first(where: { $0.paymentTypeId == selectedPaymentMethodTypeId }) {
//                customOptionSearchItem = selectedPaymentMethod
//            }
//        }
//        return customOptionSearchItem
//    }
//    var selectedPaymentMethodTypeId: String?

    init(_ paymentMethodId: String, _ paymentTypeId: String?, _ issuerId: String, _ cardUI: CardUI, _ cardData: CardData?, _ payerCost: [PXPayerCost], _ selectedPayerCost: PXPayerCost?, _ cardId: String? = nil, _ shouldShowArrow: Bool, amountConfiguration: PXAmountConfiguration?, creditsViewModel: PXCreditsViewModel? = nil, status: PXStatus, bottomMessage: PXCardBottomMessage? = nil, benefits: PXBenefits?, payerPaymentMethod: PXCustomOptionSearchItem?, behaviours: [String: PXBehaviour]?, displayInfo: PXOneTapDisplayInfo?) {
        self.paymentMethodId = paymentMethodId
        self.paymentTypeId = paymentTypeId
        self.issuerId = issuerId
        self.cardUI = cardUI
        self.cardData = cardData
        self.payerCost = payerCost
        self.selectedPayerCost = selectedPayerCost
        self.cardId = cardId
        self.shouldShowArrow = !status.isUsable() ? false : shouldShowArrow
        self.amountConfiguration = amountConfiguration
        self.creditsViewModel = creditsViewModel
        self.status = status
        self.bottomMessage = bottomMessage
        self.benefits = benefits
        self.payerPaymentMethod = payerPaymentMethod
        self.behaviours = behaviours
        self.displayInfo = displayInfo
    }
}

extension PXCardSliderViewModel: PaymentMethodOption {
    func getPaymentType() -> String {
        return paymentTypeId ?? ""
    }

    func getId() -> String {
        return paymentMethodId
    }

    func hasChildren() -> Bool {
        return false
    }

    func getChildren() -> [PaymentMethodOption]? {
        return nil
    }

    func isCard() -> Bool {
        return PXPaymentTypes.ACCOUNT_MONEY.rawValue != paymentMethodId
    }

    func isCustomerPaymentMethod() -> Bool {
        return PXPaymentTypes.ACCOUNT_MONEY.rawValue != paymentMethodId
    }

    func shouldShowInstallmentsHeader() -> Bool {
        return !userDidSelectPayerCost && status.isUsable()
    }

    func getReimbursement() -> PXInstallmentsConfiguration? {
        return benefits?.reimbursement
    }

    func getInterestFree() -> PXInstallmentsConfiguration? {
        return benefits?.interestFree
    }
}

// MARK: Setters
extension PXCardSliderViewModel {
    func setAccountMoney(accountMoneyBalance: Double) {
        self.accountMoneyBalance = accountMoneyBalance
    }
}
