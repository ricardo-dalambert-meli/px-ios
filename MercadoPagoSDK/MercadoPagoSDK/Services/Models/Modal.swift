//
//  Modal.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 30/08/21.
//

import Foundation

struct Modal: Codable {
    let title: ModalText
    let description: ModalText
    let mainButton: ModalAction
    let secondaryButton: ModalAction
}

struct ModalText: Codable {
    let message: String
    let weight: String
    let textColor: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case weight
        case textColor = "text_color"
    }
}

struct ModalAction: Codable {
    let label: String
    let action: String
    let type: String
}
