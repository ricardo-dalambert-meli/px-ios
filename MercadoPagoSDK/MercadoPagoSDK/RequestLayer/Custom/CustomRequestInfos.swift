//
//  CustomRequestInfos.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

enum CustomRequestInfos {
    case resetESCCap(cardId: String, privateKey: String?)
    case getCongrats(data: Data?, congratsModel: CustomParametersModel)
    case createPayment(privateKey: String?, publicKey: String, data: Data?, header: [String : String]?)
}

extension CustomRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .resetESCCap(let cardId, _): return "px_mobile/v1/esc_cap/\(cardId)"
        case .getCongrats(_, _): return "v1/px_mobile/congrats"
        case .createPayment(_, _, _, _): return "v1/px_mobile/payments"
        }
    }
    
    var method: HTTPMethodType {
        switch self {
        case .resetESCCap(_, _): return .delete
        case .getCongrats(_, _): return .get
        case .createPayment(_, _, _, _): return .post
        }
    }
    
    var shouldSetEnvironment: Bool {
        switch self {
        case .resetESCCap(_, _): return true
        case .createPayment(_, _, _, _), .getCongrats(_, _): return false
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .resetESCCap(_, let privateKey): if let privateKey = privateKey { return ["access_token" : privateKey] } else { return nil }
        case .getCongrats(_, let parameters): return organizeParameters(parameters: parameters)
        case .createPayment(let privateKey, let publicKey, _, _):
            if let token = privateKey {
                return [
                    "access_token" : token,
                    "public_key" : publicKey,
                    "api_version" : "2.0"
                ]
            } else {
                return [
                    "public_key" : publicKey,
                    "api_version" : "2.0"
                ]
            }
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .resetESCCap(_, _), .getCongrats(_, _): return nil
        case .createPayment(_, _, _, let header): return header
        }
    }
    
    var body: Data? {
        switch self {
        case .resetESCCap(_, _): return nil
        case .getCongrats(let data, _): return data
        case .createPayment(_, _, let data, _): return data
        }
    }
}

extension CustomRequestInfos {
    func organizeParameters(parameters: CustomParametersModel) -> [String : Any] {
        var filteredParameters: [String : Any] = [:]
        
        if parameters.publicKey != "" {
            filteredParameters.updateValue(parameters.publicKey, forKey: "public_key")
        }
        
        if parameters.paymentMethodIds != "" {
            filteredParameters.updateValue(parameters.paymentMethodIds, forKey: "payment_methods_ids")
        }
        
        if parameters.paymentId != "" {
            filteredParameters.updateValue(parameters.paymentId, forKey: "payment_ids")
        }
        
        if let privateKey = parameters.privateKey {
            filteredParameters.updateValue(privateKey, forKey: "access_token")
        }
        
        if let prefId = parameters.prefId {
            filteredParameters.updateValue(prefId, forKey: "pref_id")
        }
        
        if let campaignId = parameters.campaignId {
            filteredParameters.updateValue(campaignId, forKey: "campaign_id")
        }
        
        if let flowName = parameters.flowName {
            filteredParameters.updateValue(flowName, forKey: "flow_name")
        }
        
        if let merchantOrderId = parameters.merchantOrderId {
            filteredParameters.updateValue(merchantOrderId, forKey: "merchant_order_id")
        }
        
        filteredParameters.updateValue("2.0", forKey: "api_version")
        filteredParameters.updateValue(parameters.ifpe, forKey: "ifpe")
        filteredParameters.updateValue("MP", forKey: "platform")
        
        return filteredParameters
    }
}
