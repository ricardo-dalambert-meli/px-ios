enum CustomRequestInfos {
    case resetESCCap(cardId: String, privateKey: String?)
    case getCongrats(data: Data?, congratsModel: CustomParametersModel)
    case createPayment(privateKey: String?, publicKey: String, checkout_type: String?, data: Data?, header: [String : String]?)
}

extension CustomRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .resetESCCap(let cardId, _): return "px_mobile/v1/esc_cap/\(cardId)"
        case .getCongrats(_, _): return "v1/px_mobile/congrats"
        case .createPayment(_, _, _, _,_): return "v1/px_mobile/payments"
        }
    }
    
    var method: HTTPMethodType {
        switch self {
        case .resetESCCap(_, _): return .delete
        case .getCongrats(_, _): return .get
        case .createPayment(_, _, _, _,_): return .post
        }
    }
    
    var shouldSetEnvironment: Bool {
        switch self {
        case .resetESCCap(_, _): return true
        case .createPayment(_, _, _, _,_), .getCongrats(_, _): return false
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .resetESCCap(_, _): return nil
        case .getCongrats(_, let parameters): return organizeParameters(parameters: parameters)
        case .createPayment(_, let publicKey, _, _,_):
            return [
                "public_key" : publicKey,
                "api_version" : "2.0"
            ]
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .resetESCCap(_, _), .getCongrats(_, _): return nil
        case .createPayment(_, _, _, _, let header): return header
        }
    }
    
    var body: Data? {
        switch self {
        case .resetESCCap(_, _): return nil
        case .getCongrats(let data, _): return data
        case .createPayment(_, _, _, let data, _): return data
        }
    }
    
    var accessToken: String? {
        switch self {
        case .resetESCCap(_, let privateKey): return privateKey
        case .getCongrats(_, let parameters): return parameters.privateKey
        case .createPayment(let privateKey, _, _, _, _): return privateKey
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
        
        if let paymentTypeId = parameters.paymentTypeId {
            filteredParameters.updateValue(paymentTypeId, forKey: "payment_type_id ")
        }
        
        filteredParameters.updateValue("2.0", forKey: "api_version")
        filteredParameters.updateValue(parameters.ifpe, forKey: "ifpe")
        filteredParameters.updateValue("MP", forKey: "platform")
        
        return filteredParameters
    }
}
