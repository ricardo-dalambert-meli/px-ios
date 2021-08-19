//
//  PXProfileIDDefault.swift
//  MercadoPagoSDKV4
//
//  Created by Jonathan Scaramal on 18/08/2021.
//

import Foundation

public class PXProfileIDDefault: NSObject, PXProfileIDProtocol {
    public func getProfileID() -> String? {
        return "PXDefaultProfileID"
    }
}
