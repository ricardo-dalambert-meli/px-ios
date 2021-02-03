//
//  CheckoutWithParametersViewModel.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 15/01/21.
//

protocol CheckoutWithParametersViewModelDelegate: class {
    func initCheckoutFlow(checkoutParameters: CheckoutParametersModel)
    func empetyFields(title: String, description: String)
}

final class CheckoutWithParametersViewModel {
    //MARK: - Public properties
    weak var delegate: CheckoutWithParametersViewModelDelegate?
    
    init(delegate: CheckoutWithParametersViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    //MARK: - Public methods
    func checkoutChecks(checkoutParameters: CheckoutParametersModel) {
        guard checkoutParameters.preferedId != "", checkoutParameters.publicKey != "", checkoutParameters.privateKey != "" else {
            delegate?.empetyFields(title: "Can not init checkout flow", description: "Fill all fields before submit")
            return
        }
        
        delegate?.initCheckoutFlow(checkoutParameters: checkoutParameters)
    }
}
