//
//  TokenRequestInfos.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

enum TokenRequestInfos {
    case getToken(accessToken: String?, publicKey: String, cardTokenJSON: Data?)
    case cloneToken(tokenId: String, publicKey: String)
    case validateToken(tokenId: String, publicKey: String, body: Data)
}

extension TokenRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .getToken(_, _, _): return "v1/card_tokens"
        case .cloneToken(let tokenId, _): return "v1/card_tokens\(tokenId)/clone"
        case .validateToken(let tokenId, _, _): return "\(tokenId)"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .getToken(_, _, _), .cloneToken(_, _): return .post
        case .validateToken(_, _, _): return .put
        }
    }

    var shouldSetEnvironment: Bool {
        switch self {
        case .getToken(_, _, _): return false
        case .validateToken(_, _, _), .cloneToken(_, _): return true
        }
    }


    var parameters: [String : Any]? {
        switch self {
        case .getToken(_, let publicKey, _): return [ "public_key" : publicKey ]
        case .cloneToken(_, let publicKey), .validateToken(_, let publicKey, _): return [ "public_key" : publicKey ]
        }
    }


    var headers: [String : String]? {
        switch self {
        case .getToken(_, _, _), .cloneToken(_, _), .validateToken(_, _, _): return nil
        }
    }

    var body: Data? {
        switch self {
        case .getToken(_, _, let data): return data
        case .cloneToken(_, _): return nil
        case  .validateToken(_, _, let data): return data
        }
    }
    
    var accessToken: String? {
        switch self {
        case .getToken(let privateKey, _, _): return privateKey
        case .cloneToken(_, _), .validateToken(_, _, _): return nil
        }
    }
}
