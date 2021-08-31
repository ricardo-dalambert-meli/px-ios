//
//  Modal.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 30/08/21.
//

import Foundation

struct Modal: Codable {
    let title: PXText
    let description: PXText
    let mainButton: ModalAction
    let secondaryButton: ModalAction
}

struct ModalAction: Codable {
    let label: String
    let action: String
    let type: String
}
