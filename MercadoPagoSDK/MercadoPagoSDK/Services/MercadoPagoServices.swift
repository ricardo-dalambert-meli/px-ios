//
//  MercadoPagoServices.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation
// Se importa MLCardForm para reutilizar la clase de Reachability
import MLCardForm

internal class MercadoPagoServices: NSObject {
    private var processingModes: [String] = PXServicesURLConfigs.MP_DEFAULT_PROCESSING_MODES
    private var branchId: String?
    private var baseURL: String! = PXServicesURLConfigs.MP_API_BASE_URL
    private var gatewayBaseURL: String!
    private var language: String = NSLocale.preferredLanguages[0]

    private let customService: CustomServices
    private let remedyService: RemedyServices
    private let gatewayService: TokenService
    private let paymentService: PaymentServices

    // MARK: - Internal properties
    var reachability: Reachability?
    var hasInternet: Bool = true

    // MARK: - Open perperties
    open var publicKey: String
    open var privateKey: String?

    // MARK: - Initialization
    init(
        publicKey: String,
        privateKey: String? = nil,
        customService: CustomServices = CustomServicesImpl(),
        remedyService: RemedyServices = RemedyServicesImpl(),
        gatewayService: TokenService = TokenServiceImpl(),
        paymentService: PaymentServices = PaymentServicesImpl()
    ) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.customService = customService
        self.remedyService = remedyService
        self.gatewayService = gatewayService
        self.paymentService = paymentService
        super.init()
        addReachabilityObserver()
    }

    deinit {
        removeReachabilityObserver()
    }

    func update(processingModes: [String]? , branchId: String? = nil) {
        self.processingModes = processingModes ?? PXServicesURLConfigs.MP_DEFAULT_PROCESSING_MODES
        self.branchId = branchId
    }

    func getTimeOut() -> TimeInterval {
        return 15.0
    }

    func resetESCCap(cardId: String, onCompletion : @escaping () -> Void) {
        customService.resetESCCap(cardId: cardId, privateKey: privateKey) { _, _ in
            onCompletion()
        }
    }

    func getOpenPrefInitSearch(pref: PXCheckoutPreference, cardsWithEsc: [String], oneTapEnabled: Bool, splitEnabled: Bool, discountParamsConfiguration: PXDiscountParamsConfiguration?, flow: String?, charges: [PXPaymentTypeChargeRule], headers: [String: String]?,  newCardId: String?, callback : @escaping (PXInitDTO) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        
        
        let bodyFeatures = PXInitFeatures(oneTap: oneTapEnabled, split: splitEnabled)
        let body = PXInitBody(preference: pref, publicKey: publicKey, flow: flow, cardsWithESC: cardsWithEsc, charges: charges, discountConfiguration: discountParamsConfiguration, features: bodyFeatures, newCardId: newCardId)
        
        let bodyJSON = try? body.toJSON()
        
        paymentService.getInit(preferenceId: nil, privateKey: privateKey, body: bodyJSON, headers: headers) { dto, error in
            if let dto = dto {
                callback(dto)
            } else if let error = error {
                failure(error)
            }
        }
    }

    func getClosedPrefInitSearch(preferenceId: String, cardsWithEsc: [String], oneTapEnabled: Bool, splitEnabled: Bool, discountParamsConfiguration: PXDiscountParamsConfiguration?, flow: String?, charges: [PXPaymentTypeChargeRule], headers: [String: String]?, newCardId: String?, callback : @escaping (PXInitDTO) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        let bodyFeatures = PXInitFeatures(oneTap: oneTapEnabled, split: splitEnabled)
        let body = PXInitBody(preference: nil, publicKey: publicKey, flow: flow, cardsWithESC: cardsWithEsc, charges: charges, discountConfiguration: discountParamsConfiguration, features: bodyFeatures, newCardId: newCardId)
        
        let bodyJSON = try? body.toJSON()
        
        paymentService.getInit(preferenceId: preferenceId, privateKey: privateKey, body: bodyJSON, headers: headers) { dto, error in
            if let dto = dto {
                callback(dto)
            } else if let error = error {
                failure(error)
            }
        }
    }

    func createPayment(url: String, uri: String, transactionId: String? = nil, paymentDataJSON: Data, query: [String: String]? = nil, headers: [String: String]? = nil, callback : @escaping (PXPayment) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        customService.createPayment(privateKey: privateKey, publicKey: publicKey, data: paymentDataJSON, header: headers) { payment, error in
            if let payment = payment {
                callback(payment)
            } else if let error = error {
                failure(error)
            }
        }
    }

    func getPointsAndDiscounts(url: String, uri: String, paymentIds: [String]? = nil, paymentMethodsIds: [String]? = nil, campaignId: String?, prefId: String?, platform: String, ifpe: Bool, merchantOrderId: Int?, headers: [String: String], callback : @escaping (PXPointsAndDiscounts) -> Void, failure: @escaping (() -> Void)) {
        let parameters = CustomParametersModel(privateKey: privateKey,
                                               publicKey: publicKey,
                                               paymentMethodIds: getPaymentMethodsIds(paymentMethodsIds),
                                               paymentId: getPaymentIds(paymentIds),
                                               ifpe: String(ifpe),
                                               prefId: prefId,
                                               campaignId: campaignId,
                                               flowName: MPXTracker.sharedInstance.getFlowName(),
                                               merchantOrderId: merchantOrderId != nil ? String(merchantOrderId!) : nil)
        customService.getPointsAndDiscounts(data: nil, parameters: parameters) { pointsAndDiscounts, error in
            if let pointsAndDiscounts = pointsAndDiscounts {
                callback(pointsAndDiscounts)
            } else if let _ = error {
                failure()
            }
        }
    }

    func createToken(cardToken: PXCardToken, callback : @escaping (PXToken) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        createToken(cardToken: try? cardToken.toJSON(), callback: callback, failure: failure)
    }

    func createToken(savedESCCardToken: PXSavedESCCardToken, callback : @escaping (PXToken) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        createToken(cardToken: try? savedESCCardToken.toJSON(), callback: callback, failure: failure)
    }

    func createToken(savedCardToken: PXSavedCardToken, callback : @escaping (PXToken) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        createToken(cardToken: try? savedCardToken.toJSON(), callback: callback, failure: failure)
    }

    func createToken(cardToken: Data?, callback : @escaping (PXToken) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        gatewayService.getToken(accessToken: privateKey, publicKey: publicKey, cardTokenJSON: cardToken) { token, error in
            if let token = token {
                callback(token)
            } else if let error = error {
                failure(error)
            }
        }
    }

    func cloneToken(tokenId: String, securityCode: String, callback : @escaping (PXToken) -> Void, failure: @escaping ((_ error: NSError) -> Void)) {
        gatewayService.cloneToken(tokeniD: tokenId, publicKey: publicKey, securityCode: securityCode) { token, error in
            if let token = token {
                callback(token)
            } else if let error = error {
                failure(error)
            }
        }
    }
    
    func getRemedy(for paymentMethodId: String,
                   payerPaymentMethodRejected: PXPayerPaymentMethodRejected,
                   alternativePayerPaymentMethods: [PXRemedyPaymentMethod]?,
                   customStringConfiguration: PXCustomStringConfiguration?,
                   oneTap: Bool,
                   success : @escaping (PXRemedy) -> Void, failure: @escaping ((_ error: PXError) -> Void)) {
        let remedy = PXRemedyBody(customStringConfiguration: customStringConfiguration, payerPaymentMethodRejected: payerPaymentMethodRejected, alternativePayerPaymentMethods: alternativePayerPaymentMethods)
        
        remedyService.getRemedy(paymentMethodId: paymentMethodId, privateKey: privateKey, oneTap: oneTap, remedy: remedy) { remedy, error in
            if let remedy = remedy {
                success(remedy)
            } else if let error = error {
                failure(error)
            }
        }
    }

    //SETS
    func setBaseURL(_ baseURL: String) {
        self.baseURL = baseURL
    }

    func setGatewayBaseURL(_ gatewayBaseURL: String) {
        self.gatewayBaseURL = gatewayBaseURL
    }

    func getGatewayURL() -> String {
        if !String.isNullOrEmpty(gatewayBaseURL) {
            return gatewayBaseURL
        }
        return baseURL
    }

    class func getParamsPublicKey(_ merchantPublicKey: String) -> String {
        var params: String = ""
        params.paramsAppend(key: ApiParam.PUBLIC_KEY, value: merchantPublicKey)
        return params
    }

    class func getParamsAccessToken(_ payerAccessToken: String?) -> String {
        var params: String = ""
        params.paramsAppend(key: ApiParam.PAYER_ACCESS_TOKEN, value: payerAccessToken)
        return params
    }

    class func getParamsPublicKeyAndAcessToken(_ merchantPublicKey: String, _ payerAccessToken: String?) -> String {
        var params: String = ""

        if !String.isNullOrEmpty(payerAccessToken) {
            params.paramsAppend(key: ApiParam.PAYER_ACCESS_TOKEN, value: payerAccessToken!)
        }
        params.paramsAppend(key: ApiParam.PUBLIC_KEY, value: merchantPublicKey)

        return params
    }
    
    class func getParamsAccessTokenAndPaymentIdsAndPlatform(_ payerAccessToken: String?, _ paymentIds: [String]?, _ platform: String?) -> String {
        var params: String = ""

        if let payerAccessToken = payerAccessToken, !payerAccessToken.isEmpty {
            params.paramsAppend(key: ApiParam.PAYER_ACCESS_TOKEN, value: payerAccessToken)
        }

        if let paymentIds = paymentIds, !paymentIds.isEmpty {
            var paymentIdsString = ""
            for (index, paymentId) in paymentIds.enumerated() {
                if index != 0 {
                    paymentIdsString.append(",")
                }
                paymentIdsString.append(paymentId)
            }
            params.paramsAppend(key: ApiParam.PAYMENT_IDS, value: paymentIdsString)
        }

        if let platform = platform {
            params.paramsAppend(key: ApiParam.PLATFORM, value: platform)
        }

        return params
    }

    func getPaymentIds(_ paymentIds: [String]?) -> String {
        var paymentIdsString = ""
        
        if let paymentIds = paymentIds, !paymentIds.isEmpty {
            for (index, paymentId) in paymentIds.enumerated() {
                if index != 0 {
                    paymentIdsString.append(",")
                }
                paymentIdsString.append(paymentId)
            }
        }

        return paymentIdsString
    }

    func getPaymentMethodsIds(_ paymentMethodsIds: [String]?) -> String {
        var paymentMethodsIdsString = ""
        if let paymentMethodsIds = paymentMethodsIds {
            for (index, paymentMethodId) in paymentMethodsIds.enumerated() {
                if index != 0 {
                    paymentMethodsIdsString.append(",")
                }
                if paymentMethodId.isNotEmpty {
                    paymentMethodsIdsString.append(paymentMethodId)
                }
            }
        }
        return paymentMethodsIdsString
    }

    func setLanguage(language: String) {
        self.language = language
    }
}
