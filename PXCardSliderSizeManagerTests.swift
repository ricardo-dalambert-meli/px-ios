//
//  PXCardSliderSizeManagerTests.swift
//  MercadoPagoSDKV4-Unit-MercadoPagoSDKTests
//
//  Created by Jonathan Scaramal on 14/05/2021.
//

import XCTest
@testable import MercadoPagoSDKV4
@testable import MLCardDrawer

class PXCardSliderSizeManagerTests: XCTestCase {
    // Small devices
    func testGetCardTypeForSmallWithEverything () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.small, hasCharges: true, hasDiscounts: true, hasInstallments: true, hasSplit: true)
        
        XCTAssertEqual(cardType, MLCardDrawerType.medium)
    }
    
    func testGetCardTypeForSmallWithNothing () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.small, hasCharges: false, hasDiscounts: false, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    // Regular devices
    func testGetCardTypeForRegularWithEverything () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.regular, hasCharges: true, hasDiscounts: true, hasInstallments: true, hasSplit: true)
        
        XCTAssertEqual(cardType, MLCardDrawerType.medium)
    }
    
    func testGetCardTypeForRegularWithInstallmentsOnly () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.regular, hasCharges: false, hasDiscounts: false, hasInstallments: true, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.medium)
    }
    
    func testGetCardTypeForRegularWithChargesAndDiscountsOnly () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.regular, hasCharges: true, hasDiscounts: true, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForRegularWithNothing () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.regular, hasCharges: false, hasDiscounts: false, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    // Large devices
    func testGetCardTypeForLargeWithEverything () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.large, hasCharges: true, hasDiscounts: true, hasInstallments: true, hasSplit: true)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForLargeWithInstallmentsOnly () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.large, hasCharges: false, hasDiscounts: false, hasInstallments: true, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForLargeWithChargesAndDiscountsOnly () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.large, hasCharges: true, hasDiscounts: true, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForLargeWithNothing () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.large, hasCharges: false, hasDiscounts: false, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    // Extra large devices
    func testGetCardTypeForExtraLargeWithEverything () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.extraLarge , hasCharges: true, hasDiscounts: true, hasInstallments: true, hasSplit: true)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForExtraLargeWithInstallmentsOnly () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.extraLarge, hasCharges: false, hasDiscounts: false, hasInstallments: true, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForExtraLargeWithChargesAndDiscountsOnly () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.extraLarge, hasCharges: true, hasDiscounts: true, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
    
    func testGetCardTypeForExtraLargeWithNothing () {
        let cardType = PXCardSliderSizeManager.getCardTypeForContext(deviceSize: PXDeviceSize.Sizes.extraLarge, hasCharges: false, hasDiscounts: false, hasInstallments: false, hasSplit: false)
        
        XCTAssertEqual(cardType, MLCardDrawerType.large)
    }
}
