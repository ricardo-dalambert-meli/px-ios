//
//  MercadoPagoCheckoutServices.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 7/18/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

extension MercadoPagoCheckout {

    func getCheckoutPreference() {
        self.pxNavigationHandler.presentLoading()
        self.viewModel.mercadoPagoServicesAdapter.getCheckoutPreference(checkoutPreferenceId: self.viewModel.checkoutPreference.preferenceId, callback: { [weak self] (checkoutPreference) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.checkoutPreference = checkoutPreference
            strongSelf.viewModel.paymentData.payer = checkoutPreference.getPayer()
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.GET_PREFERENCE.rawValue), errorCallback: { [weak self] () -> Void in
                self?.getCheckoutPreference()
            })
            strongSelf.executeNextStep()
        })
    }

    func getDirectDiscount() {
        self.pxNavigationHandler.presentLoading()
        self.viewModel.mercadoPagoServicesAdapter.getDirectDiscount(amount: self.viewModel.amountHelper.amountToPay, payerEmail: self.viewModel.checkoutPreference.payer.email, callback: { [weak self] (_) in

            guard let strongSelf = self else {
                return
            }

          //  strongSelf.viewModel.paymentData.discount = discount TODO SET DISCOUNT WITH CAMPAIGN
            strongSelf.executeNextStep()

        }, failure: { [weak self] _ in

            guard let strongSelf = self else {
                return
            }

            strongSelf.executeNextStep()

        })
    }

    func initPaymentMethodPlugins() {
        if !self.viewModel.paymentMethodPlugins.isEmpty {
            initPlugin(plugins: self.viewModel.paymentMethodPlugins, index: self.viewModel.paymentMethodPlugins.count - 1)
        } else {
            self.executeNextStep()
        }
    }

    func initPlugin(plugins: [PXPaymentMethodPlugin], index: Int) {
        if index < 0 {
            DispatchQueue.main.async {
                self.viewModel.needPaymentMethodPluginInit = false
                self.executeNextStep()
            }
        } else {
            _ = self.viewModel.copyViewModelAndAssignToCheckoutStore()
            let plugin = plugins[index]
            plugin.initPaymentMethodPlugin(PXCheckoutStore.sharedInstance, { [weak self] _ in
                self?.initPlugin(plugins: plugins, index: index - 1)
            })
        }
    }

    func getPaymentMethodSearch() {
        self.pxNavigationHandler.presentLoading()

        let paymentMethodPluginsToShow = viewModel.paymentMethodPlugins.filter {$0.mustShowPaymentMethodPlugin(PXCheckoutStore.sharedInstance) == true}
        var pluginIds = [String]()
        for plugin in paymentMethodPluginsToShow {
            pluginIds.append(plugin.getId())
        }

        let cardIdsWithEsc = viewModel.mpESCManager.getSavedCardIds()

        let exclusions: MercadoPagoServicesAdapter.PaymentSearchExclusions = (self.viewModel.getExcludedPaymentTypesIds(), self.viewModel.getExcludedPaymentMethodsIds())
        let oneTapInfo: MercadoPagoServicesAdapter.PaymentSearchOneTapInfo = (cardIdsWithEsc, pluginIds)

        self.viewModel.mercadoPagoServicesAdapter.getPaymentMethodSearch(amount: self.viewModel.amountHelper.amountToPay, exclusions: exclusions, oneTapInfo: oneTapInfo, defaultPaymentMethod: self.viewModel.getDefaultPaymentMethodId(), payer: Payer(), site: MercadoPagoContext.getSite(), callback: { [weak self] (paymentMethodSearch) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.updateCheckoutModel(paymentMethodSearch: paymentMethodSearch)
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.PAYMENT_METHOD_SEARCH.rawValue), errorCallback: { [weak self] () -> Void in

                self?.getPaymentMethodSearch()
            })
            strongSelf.executeNextStep()
        })
    }

    func getIssuers() {
        self.pxNavigationHandler.presentLoading()
        guard let paymentMethod = self.viewModel.paymentData.getPaymentMethod() else {
            return
        }
        let bin = self.viewModel.cardToken?.getBin()
        self.viewModel.mercadoPagoServicesAdapter.getIssuers(paymentMethodId: paymentMethod.paymentMethodId, bin: bin, callback: { [weak self] (issuers) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.issuers = issuers

            if issuers.count == 1 {
                strongSelf.viewModel.updateCheckoutModel(issuer: issuers[0])
            }
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.GET_ISSUERS.rawValue), errorCallback: { [weak self] () in
                self?.getIssuers()
            })
            strongSelf.executeNextStep()
        })
    }

    func createCardToken(cardInformation: CardInformation? = nil, securityCode: String? = nil) {
        guard let cardInfo = self.viewModel.paymentOptionSelected as? CardInformation else {
            createNewCardToken()
            return
        }
        if cardInfo.canBeClone() {
            guard let token = cardInfo as? Token else {
                return // TODO Refactor : Tenemos unos lios barbaros con CardInformation y CardInformationForm, no entiendo porque hay uno y otr
            }
            cloneCardToken(token: token, securityCode: securityCode!)

        } else if self.viewModel.mpESCManager.hasESCEnable() {
            var savedESCCardToken: SavedESCCardToken

            let esc = self.viewModel.mpESCManager.getESC(cardId: cardInfo.getCardId())

            if !String.isNullOrEmpty(esc) {
                savedESCCardToken = SavedESCCardToken(cardId: cardInfo.getCardId(), esc: esc)
            } else {
                savedESCCardToken = SavedESCCardToken(cardId: cardInfo.getCardId(), securityCode: securityCode)
            }
            createSavedESCCardToken(savedESCCardToken: savedESCCardToken)

        } else {
            createSavedCardToken(cardInformation: cardInfo, securityCode: securityCode!)
        }
    }

    func createNewCardToken() {
        self.pxNavigationHandler.presentLoading()

        self.viewModel.mercadoPagoServicesAdapter.createToken(cardToken: self.viewModel.cardToken!, callback: { [weak self] (token) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.updateCheckoutModel(token: token)
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }
            let error = MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_TOKEN.rawValue)

            if error.apiException?.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_IDENTIFICATION_NUMBER.rawValue) == true {
                if let identificationViewController = strongSelf.pxNavigationHandler.navigationController.viewControllers.last as? IdentificationViewController {
                    identificationViewController.showErrorMessage("Revisa este dato".localized)
                }
            } else {
                strongSelf.pxNavigationHandler.dismissLoading()
                strongSelf.viewModel.errorInputs(error: error, errorCallback: { [weak self] () in
                    self?.createNewCardToken()
                })
                strongSelf.executeNextStep()
            }
        })
    }

    func createSavedCardToken(cardInformation: CardInformation, securityCode: String) {
        self.pxNavigationHandler.presentLoading()

        let cardInformation = self.viewModel.paymentOptionSelected as! CardInformation
        let saveCardToken = SavedCardToken(card: cardInformation, securityCode: securityCode, securityCodeRequired: true)

        self.viewModel.mercadoPagoServicesAdapter.createToken(savedCardToken: saveCardToken, callback: { [weak self] (token) in

            guard let strongSelf = self else {
                return
            }

            if token.lastFourDigits.isEmpty {
                token.lastFourDigits = cardInformation.getCardLastForDigits()
            }
            strongSelf.viewModel.updateCheckoutModel(token: token)
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_TOKEN.rawValue), errorCallback: { [weak self] () in
                self?.createSavedCardToken(cardInformation: cardInformation, securityCode: securityCode)
            })
            strongSelf.executeNextStep()

        })
    }

    func createSavedESCCardToken(savedESCCardToken: SavedESCCardToken) {
        self.pxNavigationHandler.presentLoading()
        self.viewModel.mercadoPagoServicesAdapter.createToken(savedESCCardToken: savedESCCardToken, callback: { [weak self] (token) in

            guard let strongSelf = self else {
                return
            }

            if token.lastFourDigits.isEmpty {
                let cardInformation = strongSelf.viewModel.paymentOptionSelected as? CardInformation
                token.lastFourDigits = cardInformation?.getCardLastForDigits() ?? ""
            }
            strongSelf.viewModel.updateCheckoutModel(token: token)
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }
            let mpError = MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_TOKEN.rawValue)

            if let apiException = mpError.apiException, apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_ESC.rawValue) ||  apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_FINGERPRINT.rawValue) {

                strongSelf.viewModel.mpESCManager.deleteESC(cardId: savedESCCardToken.cardId)

            } else {
                strongSelf.viewModel.errorInputs(error: mpError, errorCallback: { [weak self] () in
                    self?.createSavedESCCardToken(savedESCCardToken: savedESCCardToken)
                })

            }
            strongSelf.executeNextStep()

        })
    }

    func cloneCardToken(token: Token, securityCode: String) {
        self.pxNavigationHandler.presentLoading()
        self.viewModel.mercadoPagoServicesAdapter.cloneToken(tokenId: token.tokenId, securityCode: securityCode, callback: { [weak self] (token) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.updateCheckoutModel(token: token)
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_TOKEN.rawValue), errorCallback: { [weak self] () in
                self?.cloneCardToken(token: token, securityCode: securityCode)
            })
            strongSelf.executeNextStep()

        })
    }

    func getPayerCosts(updateCallback: (() -> Void)? = nil) {
        self.pxNavigationHandler.presentLoading()

        guard let paymentMethod = self.viewModel.paymentData.getPaymentMethod() else {
            return
        }

        let bin = self.viewModel.cardToken?.getBin()

        self.viewModel.mercadoPagoServicesAdapter.getInstallments(bin: bin, amount: self.viewModel.amountHelper.amountToPay, issuer: self.viewModel.paymentData.getIssuer(), paymentMethodId: paymentMethod.paymentMethodId, callback: { [weak self] (installments) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.payerCosts = installments[0].payerCosts

            let defaultPayerCost = strongSelf.viewModel.checkoutPreference.paymentPreference?.autoSelectPayerCost(installments[0].payerCosts)
            if let defaultPC = defaultPayerCost {
                strongSelf.viewModel.updateCheckoutModel(payerCost: defaultPC)
            }

            if let updateCallback = updateCallback {
                updateCallback()
            } else {
                strongSelf.executeNextStep()
            }

        }, failure: {[weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.GET_INSTALLMENTS.rawValue), errorCallback: { [weak self] () in
                self?.getPayerCosts()
            })
            strongSelf.executeNextStep()

        })
    }

    func createPayment() {
        self.pxNavigationHandler.presentLoading()

        var paymentBody: [String: Any]
        if MercadoPagoCheckoutViewModel.servicePreference.isUsingDeafaultPaymentSettings() {
            let mpPayment = MercadoPagoCheckoutViewModel.createMPPayment(preferenceId: self.viewModel.checkoutPreference.preferenceId, paymentData: self.viewModel.paymentData, binaryMode: self.viewModel.binaryMode)
            paymentBody = mpPayment.toJSON()
        } else {
            paymentBody = self.viewModel.paymentData.toJSON()
        }

        var createPaymentQuery: [String: String]? = [:]
        if let paymentAdditionalInfo = MercadoPagoCheckoutViewModel.servicePreference.getPaymentAddionalInfo() as? [String: String] {
            createPaymentQuery = paymentAdditionalInfo
        } else {
            createPaymentQuery = nil
        }

        self.viewModel.mercadoPagoServicesAdapter.createPayment(url: MercadoPagoCheckoutViewModel.servicePreference.getPaymentURL(), uri: MercadoPagoCheckoutViewModel.servicePreference.getPaymentURI(), paymentData: paymentBody as NSDictionary, query: createPaymentQuery, callback: { [weak self] (payment) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.updateCheckoutModel(payment: payment)
            strongSelf.executeNextStep()

            }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            let mpError = MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_PAYMENT.rawValue)

            if let apiException = mpError.apiException, apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_PAYMENT_WITH_ESC.rawValue) {
                strongSelf.viewModel.prepareForInvalidPaymentWithESC()
            } else if let apiException = mpError.apiException, apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_PAYMENT_IDENTIFICATION_NUMBER.rawValue) {
                self?.viewModel.paymentData.clearCollectedData()
                let mpInvalidIdentificationError = MPSDKError.init(message: "Algo salió mal...".localized, errorDetail: "El número de identificación es inválido".localized, retry: true)
                strongSelf.viewModel.errorInputs(error: mpInvalidIdentificationError, errorCallback: { [weak self] () in
                    self?.viewModel.prepareForNewSelection()
                    self?.executeNextStep()
                })
            } else {
                strongSelf.viewModel.errorInputs(error: mpError, errorCallback: { [weak self] () in
                    self?.createPayment()
                })
            }
            strongSelf.executeNextStep()

        })
    }

    func getInstructions() {
       // self.presentLoading() // Remove loading because two continue loadings doesn't work with payment plugin

        guard let paymentResult = self.viewModel.paymentResult else {
            fatalError("Get Instructions - Payment Result does no exist")
        }

        guard let paymentId = paymentResult.paymentId else {
           fatalError("Get Instructions - Payment Id does no exist")
        }

        guard let paymentTypeId = paymentResult.paymentData?.getPaymentMethod()?.paymentTypeId else {
            fatalError("Get Instructions - Payment Method Type Id does no exist")
        }

        self.viewModel.mercadoPagoServicesAdapter.getInstructions(paymentId: paymentId, paymentTypeId: paymentTypeId, callback: { [weak self] (instructionsInfo) in

            guard let strongSelf = self else {
                return
            }
            strongSelf.viewModel.instructionsInfo = instructionsInfo
            strongSelf.executeNextStep()

        }, failure: {[weak self] (error) in

            guard let strongSelf = self else {
                return
            }
            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.GET_INSTRUCTIONS.rawValue), errorCallback: { [weak self] () in
                self?.getInstructions()
            })
            strongSelf.executeNextStep()

        })
    }

    func getIdentificationTypes() {
        self.pxNavigationHandler.presentLoading()
        self.viewModel.mercadoPagoServicesAdapter.getIdentificationTypes(callback: { [weak self] (identificationTypes) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.updateCheckoutModel(identificationTypes: identificationTypes)
            strongSelf.executeNextStep()

        }, failure: { [weak self] (error) in

            guard let strongSelf = self else {
                return
            }

            strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.GET_IDENTIFICATION_TYPES.rawValue), errorCallback: { [weak self] () in
                self?.getIdentificationTypes()
            })
            strongSelf.executeNextStep()

        })
    }
}

protocol PaymentErrorHandler: NSObjectProtocol {
    func escError()
    func identificationError()
    func exitCheckout()
}

internal final class PaymentFlow {

    let paymentData: PaymentData
    let checkoutPreference: CheckoutPreference
    let binaryMode: Bool
    let paymentPlugin: PXPaymentPluginComponent?
    let paymentClosure: (() -> (status: String, statusDetail: String, receiptId: String?))?
    let navigationHandler: PXNavigationHandler
    let mercadoPagoServicesAdapter: MercadoPagoServicesAdapter

    let finishWithPaymentCallback: ((Payment) -> Void)
    let finishWithPaymentResultCallback: ((PaymentResult) -> Void)
    weak var paymentErrorHandler: PaymentErrorHandler?

    var shouldShowLoading: Bool = true

    init(paymentData: PaymentData, checkoutPreference: CheckoutPreference, binaryMode: Bool, paymentPlugin: PXPaymentPluginComponent?, paymentClosure: (() -> (status: String, statusDetail: String, receiptId: String?))?, navigationHandler: PXNavigationHandler, mercadoPagoServicesAdapter: MercadoPagoServicesAdapter, finishWithPaymentCallback: @escaping ((Payment) -> Void), finishWithPaymentResultCallback: @escaping ((PaymentResult) -> Void), paymentErrorHandler: PaymentErrorHandler) {
        self.paymentData = paymentData
        self.checkoutPreference = checkoutPreference
        self.binaryMode = binaryMode
        self.paymentPlugin = paymentPlugin
        self.paymentClosure = paymentClosure
        self.navigationHandler = navigationHandler
        self.mercadoPagoServicesAdapter = mercadoPagoServicesAdapter

        self.finishWithPaymentCallback = finishWithPaymentCallback
        self.finishWithPaymentResultCallback = finishWithPaymentResultCallback
        self.paymentErrorHandler = paymentErrorHandler
    }

    deinit {
        #if DEBUG
        print("DEINIT FLOW - \(self)")
        #endif
    }

    func setShowLoading(_ showloading: Bool) {
        shouldShowLoading = showloading
    }

    func start() {
        executeNextStep()
    }

    func executeNextStep() {
        switch self.nextStep() {
        case .defaultPayment:
            createPayment()
        case .paymentPlugin:
            createPayment()
        }
    }

    enum Steps: String {
        case paymentPlugin
        case defaultPayment
    }

    public func nextStep() -> Steps {
        if needToCreatePaymentForPaymentPlugin() {
            return .paymentPlugin
        }
        return .defaultPayment
    }

    func needToCreatePaymentForPaymentPlugin() -> Bool {
        if paymentPlugin == nil {
            return false
        }
        _ = copyViewModelAndAssignToCheckoutStore()

        if let shouldSkip = paymentPlugin?.support?(pluginStore: PXCheckoutStore.sharedInstance), !shouldSkip {
            return false
        }

        return true
    }

    func createClosurePayment() {
        if copyViewModelAndAssignToCheckoutStore() {
            paymentPlugin?.didReceive?(pluginStore: PXCheckoutStore.sharedInstance)
        }
        let (status, statusDetail, receiptId) = paymentClosure!()

        if statusDetail == RejectedStatusDetail.INVALID_ESC {
            paymentErrorHandler?.escError()
            return
        }

        // TODO: Ver esto
//        if let paymentMethodPlugin = self.checkout?.viewModel.paymentOptionSelected as? PXPaymentMethodPlugin {
//            paymentData.paymentMethod?.setExternalPaymentMethodImage(externalImage: paymentMethodPlugin.getImage())
//        }

        let paymentResult = PaymentResult(status: status, statusDetail: statusDetail, paymentData: paymentData, payerEmail: nil, paymentId: receiptId, statementDescription: nil)
        finishWithPaymentResultCallback(paymentResult)
    }

    func createPayment() {
        if shouldShowLoading {
            self.navigationHandler.presentLoading()
        }

        var paymentBody: [String: Any]
        if MercadoPagoCheckoutViewModel.servicePreference.isUsingDeafaultPaymentSettings() {
            let mpPayment = MercadoPagoCheckoutViewModel.createMPPayment(preferenceId: checkoutPreference.preferenceId, paymentData: paymentData, binaryMode: binaryMode)
            paymentBody = mpPayment.toJSON()
        } else {
            paymentBody = paymentData.toJSON()
        }

        var createPaymentQuery: [String: String]? = [:]
        if let paymentAdditionalInfo = MercadoPagoCheckoutViewModel.servicePreference.getPaymentAddionalInfo() as? [String: String] {
            createPaymentQuery = paymentAdditionalInfo
        } else {
            createPaymentQuery = nil
        }

        mercadoPagoServicesAdapter.createPayment(url: MercadoPagoCheckoutViewModel.servicePreference.getPaymentURL(), uri: MercadoPagoCheckoutViewModel.servicePreference.getPaymentURI(), paymentData: paymentBody as NSDictionary, query: createPaymentQuery, callback: { [weak self] (payment) in

            self?.finishWithPaymentCallback(payment)

            }, failure: { [weak self] (error) in

                let mpError = MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.CREATE_PAYMENT.rawValue)

                // ESC error
                if let apiException = mpError.apiException, apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_PAYMENT_WITH_ESC.rawValue) {
                    self?.paymentErrorHandler?.escError()

                // Identification number error
                } else if let apiException = mpError.apiException, apiException.containsCause(code: ApiUtil.ErrorCauseCodes.INVALID_PAYMENT_IDENTIFICATION_NUMBER.rawValue) {
                    self?.paymentErrorHandler?.identificationError()

                } else {
                    // Generic error screen
                    self?.navigationHandler.showErrorScreen(error: mpError, callbackCancel: self?.paymentErrorHandler?.exitCheckout, errorCallback: { [weak self] () in
                        self?.createPayment()
                    })
                }

        })
    }

    func copyViewModelAndAssignToCheckoutStore() -> Bool {
        // Set a copy of CheckoutVM in HookStore
        if let newPaymentData = paymentData.copy() as? PaymentData {
            PXCheckoutStore.sharedInstance.paymentData = newPaymentData
            // TODO: ver si esto es un problmea
            //PXCheckoutStore.sharedInstance.paymentOptionSelected = mercadoPagoCheckoutViewModel.paymentOptionSelected
        }
        // TODO: Hacer copia de esto
        PXCheckoutStore.sharedInstance.checkoutPreference = checkoutPreference
        return true
    }

    static func readyForPayment(paymentData: PaymentData) -> Bool {
        return paymentData.isComplete()
    }

}

extension MercadoPagoCheckout: PaymentErrorHandler {
    func escError() {
        viewModel.prepareForInvalidPaymentWithESC()
    }

    func identificationError() {
        self.viewModel.paymentData.clearCollectedData()
        let mpInvalidIdentificationError = MPSDKError.init(message: "Algo salió mal...".localized, errorDetail: "El número de identificación es inválido".localized, retry: true)
        self.viewModel.errorInputs(error: mpInvalidIdentificationError, errorCallback: { [weak self] () in
            self?.viewModel.prepareForNewSelection()
            self?.executeNextStep()

        })
    }

    func exitCheckout() {
        finish()
    }

}
