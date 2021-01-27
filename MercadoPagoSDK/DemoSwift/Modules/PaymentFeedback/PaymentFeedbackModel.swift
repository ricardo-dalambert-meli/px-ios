//
//  PaymentFeedbackModel.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 13/01/21.
//

struct PaymentFeedbackModel {
    let title: String
    let feedback: Feedback
}

enum Feedback {
    case standard(Bool)
    case noPointsNoDiscount
    case manyInstalments
    case oneInstalment
    case consumerCredits
    case consumerCreditsPlusInstalments
    case moneyAccount
    case discount
}
