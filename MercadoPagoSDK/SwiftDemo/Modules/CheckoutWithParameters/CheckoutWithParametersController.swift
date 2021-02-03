//
//  CheckoutWithParametersController.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 15/01/21.
//

import UIKit
import MercadoPagoSDK

final class CheckoutWithParametersController: UIViewController {
    //MARK: - Private properties
    private lazy var customView = CheckoutWithParametersView(delegate: self)
    private lazy var viewModel = CheckoutWithParametersViewModel(delegate: self)
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Checkout parameters"
    }
}

//MARK: - CheckoutWithParametersViewDelegate
extension CheckoutWithParametersController: CheckoutWithParametersViewDelegate {
    func userDidSubmit(checkoutParametersModel: CheckoutParametersModel) {
        viewModel.checkoutChecks(checkoutParameters: checkoutParametersModel)
    }
}

//MARK: - CheckoutWithParametersViewModelDelegate
extension CheckoutWithParametersController: CheckoutWithParametersViewModelDelegate {
    func initCheckoutFlow(checkoutParameters: CheckoutParametersModel) {
        guard let navigationController = navigationController else { return }
        // Create Builder with your publicKey and preferenceId and check if there is a paymentConfiguration.
        let builder = MercadoPagoCheckoutBuilder(publicKey: checkoutParameters.publicKey,
                                                 preferenceId: checkoutParameters.preferedId).setLanguage(checkoutParameters.language ?? "")
        
        if let payButton = checkoutParameters.payButton, payButton != "" {
            builder.addCustomTranslation(.pay_button, withTranslation: payButton)
        }

        if let payButtonProgress = checkoutParameters.payButtonProgress, payButtonProgress != "" {
            builder.addCustomTranslation(.pay_button_progress, withTranslation: payButtonProgress)
        }

        if let oneTapPayment = checkoutParameters.oneTapPayment, oneTapPayment != "" {
            builder.addCustomTranslation(.total_to_pay_onetap, withTranslation: oneTapPayment)
        }
        
        let configuration = PXAdvancedConfiguration()
        
        builder.setAdvancedConfiguration(config: configuration)
        
        // Set the payer private key
        builder.setPrivateKey(key: checkoutParameters.privateKey)

        // Create Checkout reference
        let checkout = MercadoPagoCheckout(builder: builder)

        // Start with your navigation controller.
        checkout.start(navigationController: navigationController)

    }
    
    func empetyFields(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
