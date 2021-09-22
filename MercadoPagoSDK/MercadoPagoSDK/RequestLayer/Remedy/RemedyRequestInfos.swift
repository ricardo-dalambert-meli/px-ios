//
//  RemedyRequestInfos.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

enum RemedyRequestInfos {
    case getRemedy(paymentMethodId: String, privateKey: String?, oneTap: Bool, body: Data?)
}

extension RemedyRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .getRemedy(let paymentId, _, _, _): return "px_mobile/v1/remedies/\(paymentId)"
        }
    }
    
    var mockURL: URL? {
        URL(string: "https://run.mocky.io/v3/f5cfc842-2e97-42d7-b1e5-84780f01118e")
    }
    
    var method: HTTPMethodType {
        .post
    }

    var body: Data? {
        switch self {
        case .getRemedy(_, _, _, let body): return body
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getRemedy(_, _, _, _): return nil
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .getRemedy(_, _, let oneTap, _):
            return [
            "one_tap" : oneTap ? "true" : "false"
            ]
        }
    }
    
    var accessToken: String? {
        switch self {
        case .getRemedy(_, let privateKey, _, _): return privateKey
        }
    }
}
