//
//  RequestInfos.swift
//  NetworkLayer
//
//  Created by Matheus Leandro Martins on 04/02/21.
//  Copyright © 2021 MercadoPago. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol RequestInfos {
    
    var baseURL: URL { get }
    
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }
    
    var parameterEncoding: ParameterEncoding { get }

}

extension RequestInfos {
    var baseURL: URL {
        return URL(string: "https://api.mercadopago.com/")!
    }
    
    var parameterEncoding: ParameterEncoding {
        return ParameterEncodingImpl()
    }
}
