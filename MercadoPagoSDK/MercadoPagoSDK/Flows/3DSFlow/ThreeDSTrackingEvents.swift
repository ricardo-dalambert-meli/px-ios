//
//  ThreeDSTrackingEvents.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 06/05/21.
//

enum ThreeDSTrackingEvents: TrackingEvents {
    case didGetProgramValidation([String:Any])
    
    var name: String {
        switch self {
        case .didGetProgramValidation: return "/px_checkout/program_validation"
        }
    }
    
    var properties: [String : Any] {
        switch self {
        case .didGetProgramValidation(let properties): return properties
        }
    }
    
    var needsExternalData: Bool {
        switch self {
        case .didGetProgramValidation: return false
        }
    }
}
