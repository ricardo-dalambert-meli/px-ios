//
//  PXServicesURLConfigs.swift
//  MercadoPagoServices
//
//  Created by Eden Torres on 11/8/17.
//  Copyright © 2017 Mercado Pago. All rights reserved.
//

import Foundation

enum PX_ENVIRONMENTS : CaseIterable {
    case alpha
    case beta
    case prod
}

internal class PXServicesURLConfigs {
    static let MP_ALPHA_ENV = "/alpha"
    static let MP_BETA_ENV = "/beta"
    static let MP_PROD_ENV = "/v1"

    static let NEW_API_ALPHA_ENV = "/alpha"
    static let NEW_API_BETA_ENV = "/beta"
    static let NEW_API_PROD_ENV = "/production"
    
    static let API_VERSION = "2.0"
    
    static let MP_API_BASE_URL: String = "https://api.mercadopago.com"

    static let MP_DEFAULT_PROCESSING_MODE = "aggregator"
    static let MP_DEFAULT_PROCESSING_MODES = [MP_DEFAULT_PROCESSING_MODE]
    
    static let MP_OP_ENVIROMENT = "/v1"
    
    static let PAYMENT_METHODS = "/payment_methods"
    static let PAYMENTS = "/payments"
    
    static let MP_CREATE_TOKEN_URI = MP_OP_ENVIROMENT + "/card_tokens"
    
    static let MP_IDENTIFICATION_URI = "/identification_types"
    static let MP_PROMOS_URI = MP_OP_ENVIROMENT + PAYMENT_METHODS + "/deals"
    
    var MP_SELECTED_ENV = MP_PROD_ENV
    
    var NEW_API_SELECTED_ENV = NEW_API_PROD_ENV
    
    var MP_ENVIROMENT : String

    var MP_REMEDY_URI : String
    var MP_INSTRUCTIONS_URI : String
    var MP_PAYMENTS_URI : String

    var MP_INIT_URI : String
    var MP_RESET_ESC_CAP : String
    var MP_POINTS_URI : String
    
    private static var sharedPXServicesURLConfigs: PXServicesURLConfigs = {
        let pxServicesURLConfigs = PXServicesURLConfigs()
        return pxServicesURLConfigs
    }()

    private init() {
                
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let infoPlist = NSDictionary(contentsOfFile: path) {
            // Initialize values from config
            let pxEnvironment = infoPlist["PX_ENVIRONMENT"] as? String ?? "prod"
            
            if let environment = PX_ENVIRONMENTS.allCases.first(where: { "\($0)" == pxEnvironment }) {
                switch environment {
                    case .alpha:
                        self.MP_SELECTED_ENV = PXServicesURLConfigs.MP_ALPHA_ENV
                        self.NEW_API_SELECTED_ENV = PXServicesURLConfigs.NEW_API_ALPHA_ENV
                    case .beta:
                        self.MP_SELECTED_ENV = PXServicesURLConfigs.MP_BETA_ENV
                        self.NEW_API_SELECTED_ENV = PXServicesURLConfigs.NEW_API_BETA_ENV
                    case .prod:
                        self.MP_SELECTED_ENV = PXServicesURLConfigs.MP_PROD_ENV
                        self.NEW_API_SELECTED_ENV = PXServicesURLConfigs.NEW_API_PROD_ENV
                }
            }
        }
        
        let MP_ENVIROMENT = MP_SELECTED_ENV  + "/checkout"
        
        self.MP_ENVIROMENT = MP_ENVIROMENT

        self.MP_REMEDY_URI = NEW_API_SELECTED_ENV + "/px_mobile/v1/remedies/${payment_id}"
        self.MP_INSTRUCTIONS_URI = MP_ENVIROMENT + PXServicesURLConfigs.PAYMENTS + "/${payment_id}/results"
        self.MP_PAYMENTS_URI = MP_SELECTED_ENV + "/px_mobile" + PXServicesURLConfigs.PAYMENTS

        self.MP_INIT_URI = NEW_API_SELECTED_ENV + "/px_mobile/v2/checkout"
        self.MP_RESET_ESC_CAP = NEW_API_SELECTED_ENV + "/px_mobile/v1/esc_cap"
        self.MP_POINTS_URI = MP_SELECTED_ENV + "/px_mobile" + "/congrats"
    }

    class func shared() -> PXServicesURLConfigs {
        return sharedPXServicesURLConfigs
    }
}
