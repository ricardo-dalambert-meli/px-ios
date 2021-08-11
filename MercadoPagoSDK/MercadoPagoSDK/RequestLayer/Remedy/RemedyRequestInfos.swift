//
//  RemedyRequestInfos.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

enum RemedyRequestInfos {
    case getRemedy(String, privateKey: String?, Bool, Data?)
}

extension RemedyRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .getRemedy(let paymentId, _, _, _): return "px_mobile/v1/remedies/\(paymentId)"
        }
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
        case .getRemedy(_, let privateKey, let oneTap, _):
            return [
//            "access_token" : privateKey,
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
