//
//  CheckoutWithParametersView.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 15/01/21.
//

import UIKit

protocol CheckoutWithParametersViewDelegate: class {
    func userDidSubmit(checkoutParametersModel: CheckoutParametersModel)
}

final class CheckoutWithParametersView: UIView {
    //MARK: - Private properties
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    private let preferedIdTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "Type your prefered Id here"
        return field
    }()
    
    private let publicKeyTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "Type your public key here"
        return field
    }()
    
    private let privateKeyTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "Type your private key here"
        return field
    }()
    
    private let payButtonTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "Pay button title (Optional)"
        return field
    }()
    
    private let buttonLoadingTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "Loading text on button (Optional)"
        return field
    }()
    
    private let oneTapTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "One tap text (Optional)"
        return field
    }()
    
    private let languageTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textAlignment = .center
        field.placeholder = "Type the language here"
        return field
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        button.setTitle("Init checkout flow", for: .normal)
        return button
    }()
    
    //MARK: - Public properties
    weak var delegate: CheckoutWithParametersViewDelegate?
    
    //MARK: - Initialization
    init(delegate: CheckoutWithParametersViewDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupSubmitButton() {
        submitButton.addTarget(self, action: #selector(userDidSubmit), for: .touchUpInside)
    }
    
    @objc private func userDidSubmit() {
        let checkoutParameters = CheckoutParametersModel(preferedId: preferedIdTextField.text ?? "",
                                                         publicKey: publicKeyTextField.text ?? "",
                                                         privateKey: privateKeyTextField.text ?? "",
                                                         payButton: payButtonTextField.text,
                                                         payButtonProgress: buttonLoadingTextField.text,
                                                         oneTapPayment: oneTapTextField.text,
                                                         language: languageTextField.text)
        delegate?.userDidSubmit(checkoutParametersModel: checkoutParameters)
    }
}

//MARK: - ViewConfiguration
extension CheckoutWithParametersView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [mainStack])
        mainStack.addArrangedSubviews(views: [
            preferedIdTextField,
            publicKeyTextField,
            privateKeyTextField,
            payButtonTextField,
            buttonLoadingTextField,
            oneTapTextField,
            languageTextField,
            submitButton
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            submitButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
        setupSubmitButton()
    }
}
