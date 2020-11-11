//
//  ViewController.swift
//  ExampleSwift
//
//  Created by Juan sebastian Sanzone on 11/9/18.
//  Copyright © 2018 Juan Sebastian Sanzone. All rights reserved.
// Check full documentation: http://mercadopago.github.io/px-ios/v4/
//

import UIKit

#if PX_PRIVATE_POD
    import MercadoPagoSDKV4
#else
    import MercadoPagoSDK
#endif

// Check full documentation: http://mercadopago.github.io/px-ios/v4/
class ViewController: UIViewController {
    private var checkout: MercadoPagoCheckout?
    
    // Collector Public Key
    private let publicKey : String = "TEST-e28d5a35-dece-45c9-9618-e8cc5dec6c42"
    
    // Preference ID
    private let preferenceId : String = "656525290-c715a5b1-7fe2-4ad4-af22-4d538cc649ac" //"656525290-7bda964b-26d9-4352-a04c-1b04801627ee"
    
    // Payer private key
    private let privateKey : String = "TEST-7215456036166479-101915-223c2540d9126044887a840cfae544a9-660760647"
    
    @IBAction func initDefault(_ sender: Any) {
        // runMercadoPagoCheckout()
//         runMercadoPagoCheckoutWithLifecycle()
        runMercadoPagoCheckoutWithLifecycleAndCustomProcessor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let col1 = UIColor(red: 34.0/255.0, green: 211/255.0, blue: 198/255.0, alpha: 1)
        let col2 = UIColor(red: 145/255.0, green: 72.0/255.0, blue: 203/255.0, alpha: 1)
        gradient.colors = [col1.cgColor, col2.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func runMercadoPagoCheckout() {
        // 1) Create Builder with your publicKey and preferenceId.
        let builder = MercadoPagoCheckoutBuilder(publicKey: publicKey, preferenceId: preferenceId).setLanguage("es")

        // 2) Create Checkout reference
        checkout = MercadoPagoCheckout(builder: builder)

        // 3) Start with your navigation controller.
        if let myNavigationController = navigationController {
            checkout?.start(navigationController: myNavigationController)
        }
    }
    
    private func runMercadoPagoCheckoutWithLifecycleAndCustomProcessor() {
        
        // Create charge rules
        var pxPaymentTypeChargeRules : [PXPaymentTypeChargeRule] = []
        
        pxPaymentTypeChargeRules.append(PXPaymentTypeChargeRule.init(paymentTypeId: PXPaymentTypes.ACCOUNT_MONEY.rawValue, amountCharge: 10.00 ))

//        // Charge rule with custom dialog
//
//        let alertController : UIAlertController = UIAlertController.init(title: "Detalle del cargo", message: "Este es el detalle del cargo que visualizás", preferredStyle: .alert)
//
//        pxPaymentTypeChargeRules.append(PXPaymentTypeChargeRule.init(paymentTypeId: PXPaymentTypes.CREDIT_CARD.rawValue, amountCharge: 15.00, detailModal: alertController ))
//
  
        // Free charge rule
        pxPaymentTypeChargeRules.append(PXPaymentTypeChargeRule.init(paymentTypeId: PXPaymentTypes.CREDIT_CARD.rawValue, message: "Mensaje de resaltado"))
        
        // Create an instance of your custom payment processor
        let paymentProcessor : PXPaymentProcessor = CustomPaymentProcessor()
        
        // Create a payment configuration instance using the recently created payment processor
        let paymentConfiguration = PXPaymentConfiguration(paymentProcessor: paymentProcessor)
        
        // Add charge rules
        paymentConfiguration.addChargeRules(charges: pxPaymentTypeChargeRules)
        
        // Create a Builder with your publicKey, preferenceId and paymentConfiguration
        let builder = MercadoPagoCheckoutBuilder(publicKey: publicKey, preferenceId: preferenceId, paymentConfiguration: paymentConfiguration).setLanguage("es")
        
//        let checkoutPreference = PXCheckoutPreference.init(preferenceId: preferenceId)
//
//        let builder = MercadoPagoCheckoutBuilder.init(publicKey: publicKey, checkoutPreference: checkoutPreference, paymentConfiguration: paymentConfiguration)
        
        // Instantiate a configuration object
        let configuration = PXAdvancedConfiguration()
         
        // Set expressEnabled true to use one-tap instead of groups flow
        configuration.expressEnabled = true
        
        // Add custom PXDynamicViewController component
        configuration.dynamicViewControllersConfiguration = [CustomPXDynamicComponent()]
        
        // Configure the builder object
        builder.setAdvancedConfiguration(config: configuration)
        
        // Set the payer private key
        builder.setPrivateKey(key: privateKey)

        // Create Checkout reference
        checkout = MercadoPagoCheckout(builder: builder)

        // Start with your navigation controller.
        if let myNavigationController = navigationController {
            checkout?.start(navigationController: myNavigationController, lifeCycleProtocol: self)
        }
    }

    private func runMercadoPagoCheckoutWithLifecycle() {
        // Create Builder with your publicKey and preferenceId.
        let builder = MercadoPagoCheckoutBuilder(publicKey: publicKey, preferenceId: preferenceId).setLanguage("es")
        
        let configuration = PXAdvancedConfiguration()
        
//        configuration.expressEnabled = true
        
        builder.setAdvancedConfiguration(config: configuration)
        
        // Set the payer private key
        builder.setPrivateKey(key: privateKey)
        
        // Add custom translations (px_custom_texts)
        builder.addCustomTranslation(.pay_button, withTranslation: "Pagar custom")
        builder.addCustomTranslation(.pay_button_progress, withTranslation: "Pagando custom...")
        builder.addCustomTranslation(.total_to_pay_onetap, withTranslation: "Total a pagar custom")

        // Create Checkout reference
        checkout = MercadoPagoCheckout(builder: builder)

        // Start with your navigation controller.
        if let myNavigationController = navigationController {
            checkout?.start(navigationController: myNavigationController, lifeCycleProtocol: self)
        }
    }
}

// MARK: Optional Lifecycle protocol implementation example.
extension ViewController: PXLifeCycleProtocol {
    func finishCheckout() -> ((PXResult?) -> Void)? {
        return nil
    }

    func cancelCheckout() -> (() -> Void)? {
        return nil
    }

    func changePaymentMethodTapped() -> (() -> Void)? {
        return { () in
            print("px - changePaymentMethodTapped")
        }
    }
}
