//
//  FeatureListModel.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 12/01/21.
//

import Foundation

struct FeatureListModel {
    let featureName: String
    let requirements: String?
    let feature: Feature
}

enum Feature {
    case standardCheckout
    case customProcesadora
    case customBuilder
    case withCharges
    case chargesWithAlert
    case noCharges
    case paymentFeedback
    case withParameters
}
