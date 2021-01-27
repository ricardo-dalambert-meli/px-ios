//
//  FeatureListController.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 12/01/21.
//

import UIKit
import MercadoPagoSDK

final class FeatureListController: UIViewController {
    //MARK: - Private properties
    private let viewModel = FeatureListViewModel()
    private lazy var customView = FeatureListView(delegate: self,
                                                  dataSource: self,
                                                  pickerDelegate: self,
                                                  userProfiles: viewModel.getUserProfiles())
    
    //MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.setSelectedProfile(userProfile: viewModel.getCurrentUser())
        title = "Feature List"
    }
}

extension FeatureListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeatureListCell.reuseIdentifier) as? FeatureListCell else { return UITableViewCell() }
        cell.setupInfos(featureName: viewModel.getFeatureInfos(index: indexPath.row).0, requirement: viewModel.getFeatureInfos(index: indexPath.row).1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getFeature(index: indexPath.row) {
        case .standardCheckout: goToStandardCheckoutFlow()
        case .customProcesadora: goToCustomProcesadoraFlow()
        case .customBuilder: goToCustomBuilderFlow()
        case .withCharges: goToCheckoutWithChargesFlow()
        case .chargesWithAlert: goToCheckoutWithAlert()
        case .noCharges: goToZeroChargesFlow()
        case .withParameters: goToCheckoutWithParameters()
        case .paymentFeedback: goToPaymentFeedback()
        }
    }
}

extension FeatureListController {
    private func startCheckoutFlow(
        paymentConfigurtion: PXPaymentConfiguration? = nil,
        payButton: String? = nil,
        payButtonProgress: String? = nil,
        oneTapPayment: String? = nil
    ) {
        guard let navigationController = navigationController else { return }
        // Create Builder with your publicKey and preferenceId and check if there is a paymentConfiguration.
        let builder = paymentConfigurtion == nil ?
        MercadoPagoCheckoutBuilder(publicKey: viewModel.getPublicKey(), preferenceId: viewModel.getPreferenceId()).setLanguage("pt-BR") :
        MercadoPagoCheckoutBuilder(publicKey: viewModel.getPublicKey(), preferenceId: viewModel.getPreferenceId(), paymentConfiguration: paymentConfigurtion!).setLanguage("pt-BR")
        
        if let payButton = payButton {
            builder.addCustomTranslation(.pay_button, withTranslation: payButton)
        }
        
        if let payButtonProgress = payButtonProgress {
            builder.addCustomTranslation(.pay_button_progress, withTranslation: payButtonProgress)
        }
        
        if let oneTapPayment = oneTapPayment {
            builder.addCustomTranslation(.total_to_pay_onetap, withTranslation: oneTapPayment)
        }
        
        let configuration = PXAdvancedConfiguration()
        
        builder.setAdvancedConfiguration(config: configuration)
        
        // Set the payer private key
        builder.setPrivateKey(key: viewModel.getPrivateKey())

        // Create Checkout reference
        let checkout = MercadoPagoCheckout(builder: builder)

        // Start with your navigation controller.
        checkout.start(navigationController: navigationController, lifeCycleProtocol: self)
    }
    
    private func goToStandardCheckoutFlow() {
        startCheckoutFlow()
    }
    
    //Check if this flow is used nowadays
    private func goToCustomProcesadoraFlow() {
        let paymentProcessor : PXPaymentProcessor = CustomPaymentProcessor()

        let paymentConfiguration = PXPaymentConfiguration(paymentProcessor: paymentProcessor)
 
        startCheckoutFlow(paymentConfigurtion: paymentConfiguration)
    }
    
    private func goToCustomBuilderFlow() {
        startCheckoutFlow(payButton: "Payment custom title", payButtonProgress: "Custom loading", oneTapPayment: "Custom one tap payment")
    }
    
    private func goToCheckoutWithChargesFlow() {
        // Create charge rules
        var pxPaymentTypeChargeRules : [PXPaymentTypeChargeRule] = []
        
        pxPaymentTypeChargeRules.append(PXPaymentTypeChargeRule.init(paymentTypeId: PXPaymentTypes.CREDIT_CARD.rawValue, amountCharge: 10.00))
        // Create an instance of your custom payment processor
        let paymentProcessor : PXPaymentProcessor = CustomPaymentProcessor()
            
        // Create a payment configuration instance using the recently created payment processor
        var paymentConfiguration = PXPaymentConfiguration(paymentProcessor: paymentProcessor)
              
        // Add charge rules
        paymentConfiguration = paymentConfiguration.addChargeRules(charges: pxPaymentTypeChargeRules)
        
        startCheckoutFlow(paymentConfigurtion: paymentConfiguration)
    }
    
    private func goToCheckoutWithAlert() {
        var pxPaymentTypeChargeRules : [PXPaymentTypeChargeRule] = []
        
        let alert = UIAlertController(title: "Charges detail", message: "Charges description", preferredStyle: .alert)
        
        pxPaymentTypeChargeRules.append(PXPaymentTypeChargeRule(paymentTypeId: PXPaymentTypes.CREDIT_CARD.rawValue, amountCharge: 15.00, detailModal: alert))
        
        let paymentProcessor : PXPaymentProcessor = CustomPaymentProcessor()
        
        let paymentConfiguration = PXPaymentConfiguration(paymentProcessor: paymentProcessor)
        
        _ = paymentConfiguration.addChargeRules(charges: pxPaymentTypeChargeRules)

        startCheckoutFlow(paymentConfigurtion: paymentConfiguration)
    }
    
    //Visual bugs to be solved
    private func goToZeroChargesFlow() {
        var pxPaymentTypeChargeRules : [PXPaymentTypeChargeRule] = []
         
        // Free charge rule
        pxPaymentTypeChargeRules.append(PXPaymentTypeChargeRule.init(paymentTypeId: PXPaymentTypes.CREDIT_CARD.rawValue, message: "No charges for you"))
        
        let paymentProcessor : PXPaymentProcessor = CustomPaymentProcessor()
        
        let paymentConfiguration = PXPaymentConfiguration(paymentProcessor: paymentProcessor)
        
        _ = paymentConfiguration.addChargeRules(charges: pxPaymentTypeChargeRules)
        
        startCheckoutFlow(paymentConfigurtion: paymentConfiguration)
    }
    
    private func goToCheckoutWithParameters() {
        let controller = CheckoutWithParametersController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func goToPaymentFeedback() {
        let controller = PaymentFeedbackController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - ProfileUserPickerDelegate
extension FeatureListController: ProfileUserPickerDelegate {
    func didChange(userPofile: String) {
        customView.setSelectedProfile(userProfile: userPofile)
    }
    
    func didClosePickerView(profileIndex: Int) {
        viewModel.updateProfileIndex(index: profileIndex)
    }
}

//MARK: - namePXLifeCycleProtocol (OPTIONAL)
extension FeatureListController: PXLifeCycleProtocol {
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
