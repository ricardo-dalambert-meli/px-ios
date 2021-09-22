//
//  PXRemediesTrackEvents.swift
//  MercadoPagoSDKV4
//
//  Created by Pedro Silva Dos Santos on 15/09/21.
//

enum PXRemediesTrackEvents: TrackingEvents {
    case didResultRemedyError([String:Any])
    case viewErrorPaymentResult([String:Any])
    case changePaymentMethod(isFrom: String)
    case didShowRemedyErrorModal
    case didCloseRemedyModalAbort

    
    var name: String {
        switch self {
        case .viewErrorPaymentResult(_): return "/px_checkout/result/error"
        case .didResultRemedyError(_): return "px_checkout/result/error/remedy"
        case .changePaymentMethod: return "/px_checkout/result/error/change_payment_method"
        case .didShowRemedyErrorModal: return "/px_checkout/result/error/remedy/modal"
        case .didCloseRemedyModalAbort: return "/px_checkout/result/error/remedy/modal/abort"
        }
    }
    
    var properties: [String : Any] {
        switch self {
            case .didResultRemedyError(let properties),.viewErrorPaymentResult(let properties): return properties
            case .changePaymentMethod(let from): return ["from": from]
            case .didCloseRemedyModalAbort: return [:]
            case .didShowRemedyErrorModal: return [:]
           
        }
    }
}
