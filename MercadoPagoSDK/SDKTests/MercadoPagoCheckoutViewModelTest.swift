//
//  MercadoPagoCheckoutViewModelTest.swift
//  SDKTests
//
//  Created by Matheus Leandro Martins on 01/02/21.
//  Copyright © 2021 MercadoPago. All rights reserved.
//

import XCTest
@testable import MercadoPagoSDK

final class ConfigurationServiceMock: PXPaymentConfigurationService {
    func getPayerCostsForPaymentMethod(_ id: String, splitPaymentEnabled: Bool) -> [PXPayerCost]? {
        return nil
    }
    
    func getAmountConfigurationForPaymentMethod(_ id: String?) -> PXAmountConfiguration? {
        return nil
    }
    
    func getSplitConfigurationForPaymentMethod(_ id: String) -> PXSplitConfiguration? {
        return nil
    }
    
    func getSelectedPayerCostsForPaymentMethod(_ id: String, splitPaymentEnabled: Bool) -> PXPayerCost? {
        return nil
    }
    
    func getAmountToPayWithoutPayerCostForPaymentMethod(_ id: String?) -> Double? {
        return nil
    }
    
    func getDiscountInfoForPaymentMethod(_ id: String) -> String? {
        return nil
    }
    
    func getCreditsInfoForPaymentMethod(_ id: String) -> String? {
        return nil
    }
    
    func getDiscountConfigurationForPaymentMethod(_ id: String) -> PXDiscountConfiguration? {
        return nil
    }
    
    func getDiscountConfigurationForPaymentMethodOrDefault(_ id: String?) -> PXDiscountConfiguration? {
        return nil
    }
    
    func getDefaultDiscountConfiguration() -> PXDiscountConfiguration? {
        return nil
    }
    
    func getConfigurationsForPaymentMethod(_ id: String) -> [PXPaymentOptionConfiguration]? {
        return nil
    }
    
    func getPaymentOptionConfiguration(_ paymentOptionID: String) -> PXPaymentOptionConfiguration? {
        return nil
    }
    
    func setConfigurations(_ configurations: Set<PXPaymentMethodConfiguration>) {
        
    }
    
    func setDefaultDiscountConfiguration(_ discountConfiguration: PXDiscountConfiguration?) {
        
    }
}

class MercadoPagoCheckoutViewModelTest: XCTestCase {
    var configurationServiceMock: ConfigurationServiceMock!
    var sut: MercadoPagoCheckoutViewModel!
    
    override func setUp() {
        super.setUp()
        configurationServiceMock = ConfigurationServiceMock()
        sut = MercadoPagoCheckoutViewModel(checkoutPreference: PXCheckoutPreference(preferenceId: "Test"),
                                           publicKey: "Test",
                                           privateKey: "Teste",
                                           advancedConfig: nil,
                                           trackingConfig: nil,
                                           paymentConfigurationService: configurationServiceMock
        )
    }

    func testSetNavigationHandler() {
        let controller = UINavigationController()
        XCTAssertTrue(sut.pxNavigationHandler.navigationController != controller)
        sut.setNavigationHandler(handler: PXNavigationHandler(navigationController: controller))
        XCTAssertTrue(sut.pxNavigationHandler.navigationController == controller)
    }
    
    func testClearDiscount() {
        sut.paymentData.setDiscount(PXDiscount(id: "", name: "", percentOff: 1.0, amountOff: 10.0, couponAmount: 1.0, currencyId: "R$"),
                                    withCampaign: PXCampaign(id: 0, code: nil, name: nil, maxCouponAmount: 1.0),
                                    consumedDiscount: true,
                                    discountDescription: nil)
        XCTAssertTrue(sut.paymentData.discount != nil)
        sut.clearDiscount()
        XCTAssertTrue(sut.paymentData.discount == nil)
    }
    
    func testGetCardsIdsWithESC() {
        XCTAssertTrue(sut.getCardsIdsWithESC() == [])
    }
}
