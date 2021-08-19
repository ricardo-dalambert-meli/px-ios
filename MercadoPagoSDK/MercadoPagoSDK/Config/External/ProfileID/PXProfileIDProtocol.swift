//
//  PXProfileIDProtocol.swift
//  MercadoPagoSDKV4
//
//  Created by Jonathan Scaramal on 17/08/2021.
//

import Foundation

@objc public protocol PXProfileIDProtocol: NSObjectProtocol {
    func getProfileID() -> String?
}
