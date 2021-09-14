//
//  PXNewResultTrackingEvents.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 06/05/21.
//

enum PXResultTrackingEvents: TrackingEvents {
    // MARK: - Events
    case didTapOnAllDiscounts
    case didtapOnDownload
    case didTapOnReceipt
    case didTapOnScore
    case didTapOnDeeplink([String:Any])
    case didTapOnCrossSelling
    case didShowRemedyError([String:Any])
    
    // MARK: - ScreenEvents
    case checkoutPaymentApproved([String:Any])
    case checkoutPaymentInProcess([String:Any])
    case checkoutPaymentRejected([String:Any])
    
    case congratsPaymentApproved([String:Any])
    case congratsPaymentInProcess([String:Any])
    case congratsPaymentRejected([String:Any])
    
    case didResultRemedyError([String:Any])
    case didShowRemedyErrorModal([String:Any])
    case didCloseRemedyModalAbort([String:Any])
    case changePaymentMethod([String:Any])
    case viewErrorPaymentResult([String:Any])
    case viewmodalPaymentMethod([String:Any])
    
    
    var name: String {
        switch self {
        case .didTapOnAllDiscounts: return "/px_checkout/result/success/tap_see_all_discounts"
        case .didtapOnDownload: return "/px_checkout/result/success/tap_download_app"
        case .didTapOnReceipt: return "/px_checkout/result/success/tap_view_receipt"
        case .didTapOnScore: return "/px_checkout/result/success/tap_score"
        case .didTapOnDeeplink(_): return "/px_checkout/result/success/deep_link"
        case .didTapOnCrossSelling: return "/px_checkout/result/success/tap_cross_selling"
        case .didShowRemedyError(_): return "/px_checkout/result/error/primary_action"
              
        case .checkoutPaymentApproved(_): return "/px_checkout/result/success"
        case .checkoutPaymentInProcess(_): return "/px_checkout/result/further_action_needed"
        case .checkoutPaymentRejected(_): return "/px_checkout/result/error"
        case .congratsPaymentApproved(_): return "/payment_congrats/result/success"
        case .congratsPaymentInProcess(_): return "/payment_congrats/result/further_action_needed"
        case .congratsPaymentRejected(_): return "/payment_congrats/result/error"
            
        case .didResultRemedyError(_): return "px_checkout/result/error/remedy" // "from": "modal
        case .changePaymentMethod(_): return "/px_checkout/result/error/change_payment_method" // "from": "modal | view" - segundo botao
        case .didShowRemedyErrorModal(_): return "/px_checkout/result/error/remedy/modal" //mercado créditos - enviar endpoint remedies/:paymentId viene el nodo modal
        case .didCloseRemedyModalAbort(_): return "/px_checkout/result/error/remedy/modal/abort" //clicando no x do modal
        case .viewErrorPaymentResult(_): return "/px_checkout/result/error" //Nodo remedies -> extra_info agregar info de card_size
        }
    }
    
    var properties: [String : Any] {
        switch self {
        case .didTapOnAllDiscounts, .didtapOnDownload, .didTapOnReceipt, .didTapOnScore, .didTapOnCrossSelling: return [:]
        case .didTapOnDeeplink(let properties), .didShowRemedyError(let properties), .checkoutPaymentApproved(let properties),
             .checkoutPaymentInProcess(let properties), .checkoutPaymentRejected(let properties),
             .congratsPaymentApproved(let properties), .congratsPaymentInProcess(let properties),
             .congratsPaymentRejected(let properties): return properties
        case .didResultRemedyError(let properties), .didShowRemedyErrorModal(let properties), .didCloseRemedyModalAbort(let properties), .changePaymentMethod(let properties), .viewErrorPaymentResult(let properties),.viewmodalPaymentMethod(let properties) : return properties
        }
    }
}
