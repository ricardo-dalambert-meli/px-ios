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
    var displayInfo: PXOneTapDisplayInfo?
    
    var accountMoneyBalance: Double?
    
    let creditsViewModel: PXCreditsViewModel?
    
    var isCredits: Bool {
        return self.selectedApplication?.paymentMethodId == PXPaymentTypes.CONSUMER_CREDITS.rawValue
    }
    
    var applications : [PXApplicationId: PXCardSliderApplicationData]?
    
    var selectedApplicationId : PXApplicationId?
    
    var selectedApplication: PXCardSliderApplicationData? {
        guard let applicationsData = applications, applicationsData.count > 0, let selectedApplicationId = selectedApplicationId else { return nil }
        
        return applicationsData[selectedApplicationId] ?? nil
    }
    
    init(_ applications: [PXApplicationId: PXCardSliderApplicationData], _ selectedApplicationId: String?, _ issuerId: String, _ cardUI: CardUI, _ cardId: String? = nil, creditsViewModel: PXCreditsViewModel? = nil, displayInfo: PXOneTapDisplayInfo?) {
        self.issuerId = issuerId
        self.cardUI = cardUI
        self.cardId = cardId
        self.creditsViewModel = creditsViewModel
        self.displayInfo = displayInfo
        self.applications = applications
        self.selectedApplicationId = selectedApplicationId
    }
    
    // MARK: - Public methods
    func trackCard(state: String) {
        MPXTracker.sharedInstance.trackEvent(path: "/px_checkout/program_validation", properties: ["option_selected" : state])
    }
}

extension PXCardSliderViewModel: PaymentMethodOption {
    func getPaymentType() -> String {
        return selectedApplication?.paymentTypeId ?? ""
    }

    func getId() -> String {
        return selectedApplication?.paymentMethodId ?? ""
    }

    func hasChildren() -> Bool {
        return false
    }

    func getChildren() -> [PaymentMethodOption]? {
        return nil
    }

    func isCard() -> Bool {
        return PXPaymentTypes.ACCOUNT_MONEY.rawValue != selectedApplication?.paymentMethodId
    }

    func isCustomerPaymentMethod() -> Bool {
        return PXPaymentTypes.ACCOUNT_MONEY.rawValue != selectedApplication?.paymentMethodId
    }

    func shouldShowInstallmentsHeader() -> Bool {
        guard let selectedApplication = selectedApplication else { return false }
        return !selectedApplication.userDidSelectPayerCost && selectedApplication.status.isUsable()
    }

    func getReimbursement() -> PXInstallmentsConfiguration? {
        guard let selectedApplication = selectedApplication else { return nil }
        return selectedApplication.benefits?.reimbursement
    }

    func getInterestFree() -> PXInstallmentsConfiguration? {
        guard let selectedApplication = selectedApplication else { return nil }
        return selectedApplication.benefits?.interestFree
    }
}

// MARK: Setters
extension PXCardSliderViewModel {
    func setAccountMoney(accountMoneyBalance: Double) {
        self.accountMoneyBalance = accountMoneyBalance
    }
}
