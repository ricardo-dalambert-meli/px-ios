//
//  PXRemediesTrackEvents.swift
//  MercadoPagoSDKV4
//
//  Created by Pedro Silva Dos Santos on 15/09/21.
//

enum PXRemediesTrackEvents: TrackingEvents {
    case didResultRemedyError([String:Any])
    case didShowRemedyErrorModal([String:Any])
    case didCloseRemedyModalAbort
    case changePaymentMethod(isFrom: String)
    case viewErrorPaymentResult([String:Any])
    
    var name: String {
        switch self {
 
        case .didResultRemedyError: return "px_checkout/result/error/remedy"
        case .changePaymentMethod: return "/px_checkout/result/error/change_payment_method"
        case .didShowRemedyErrorModal: return "/px_checkout/result/error/remedy/modal"
        case .didCloseRemedyModalAbort: return "/px_checkout/result/error/remedy/modal/abort"
        case .viewErrorPaymentResult(_): return "/px_checkout/result/error"
        }
    }
    
    var properties: [String : Any] {
        switch self {
            case .didResultRemedyError(let properties), .didShowRemedyErrorModal(let properties),   .viewErrorPaymentResult(let properties): return properties
            case .changePaymentMethod(let from): return ["from": from]
            case .didCloseRemedyModalAbort: return [:]
           
        }
    }
}
