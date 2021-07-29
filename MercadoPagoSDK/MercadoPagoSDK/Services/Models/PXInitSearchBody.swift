//
//  PXInitSearchBody.swift
//  MercadoPagoSDK
//
//  Created by Esteban Adrian Boffa on 11/08/2019.
//

import Foundation
import UIKit

struct PXInitBody: Codable {
    let preference: PXCheckoutPreference?
    let publicKey: String
    let flow: String?
    let newCardId: String?
    let cardsWithESC: [String]
    let charges: [PXPaymentTypeChargeRule]
    let discountConfiguration: PXDiscountParamsConfiguration?
    let features: PXInitFeatures

    init(preference: PXCheckoutPreference?, publicKey: String, flow: String?, cardsWithESC: [String], charges: [PXPaymentTypeChargeRule], discountConfiguration: PXDiscountParamsConfiguration?, features: PXInitFeatures, newCardId: String?) {
        self.preference = preference
        self.publicKey = publicKey
        self.flow = flow
        self.cardsWithESC = cardsWithESC
        self.charges = charges
        self.discountConfiguration = discountConfiguration
        self.features = features
        self.newCardId = newCardId
    }

    enum CodingKeys: String, CodingKey {
        case preference
        case publicKey = "public_key"
        case flow = "flow"
        case cardsWithESC = "cards_with_esc"
        case charges
        case discountConfiguration = "discount_configuration"
        case features
        case newCardId = "new_card_id"
    }

    public func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}

struct PXInitFeatures: Codable {
    let oneTap: Bool
    let split: Bool
    let odr: Bool
    let comboCard: Bool
    let hybridCard: Bool
    let validationPrograms: [String]
    let pix: Bool
    let customCharges: Bool

    init(oneTap: Bool = true, split: Bool, odr: Bool = true, comboCard: Bool = false, hybridCard: Bool = false, validationPrograms: [String] = [], pix: Bool = true, customCharges: Bool = true) {
        self.oneTap = oneTap
        self.split = split
        self.odr = odr
        self.comboCard = comboCard
        self.hybridCard = hybridCard
        self.validationPrograms = validationPrograms
        self.pix = pix
        self.customCharges = customCharges
    }

    enum CodingKeys: String, CodingKey {
        case oneTap = "one_tap"
        case split = "split"
        case odr
        case comboCard = "combo_card"
        case hybridCard = "hybrid_card"
        case validationPrograms = "validations_programs"
        case pix
        case customCharges = "custom_charges"
    }
}
