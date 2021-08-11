//
//  CustomParametersModel.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

struct CustomParametersModel {
    let privateKey: String?
    let publicKey: String
    let paymentMethodIds: String
    let paymentId: String
    let ifpe: String
    let prefId: String?
    let campaignId: String?
    let flowName: String?
    let merchantOrderId: String?
}
