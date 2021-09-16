//
//  CongratsTrackingEvents.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 06/05/21.
//

enum CongratsTrackingEvents: TrackingEvents {
    case didTapDiscount([String:Any])
    
    var name: String {
        switch self {
        case .didTapDiscount: return "/px_checkout/result/success/tap_discount_item"
        }
    }
    
    var properties: [String : Any] {
        switch self {
        case .didTapDiscount(let properties): return properties
        }
    }
    
    var needsExternalData: Bool {
        switch self {
        case .didTapDiscount: return true
        }
    }
}
