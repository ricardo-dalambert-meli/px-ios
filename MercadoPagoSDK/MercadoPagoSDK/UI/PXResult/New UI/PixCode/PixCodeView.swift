//
//  PixCodeView.swift
//  AndesUI
//
//  Created by Matheus Leandro Martins on 22/04/21.
//

import UIKit

final class PixCodeView: UIView {
    // MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let firstStepLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1. Copie o código abaixo"
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 4
        label.text = "378125673476124563547815673825768132"
        return label
    }()
    
    private let copyCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Copiar código", for: .normal)
        return button
    }()
    
    private let stepsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let secondStepLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2. Cole"
        return label
    }()
    
    private let thirdStepLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3. pague"
        return label
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "4. Copie o código abaixo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    init(pixModel: PixCodeModel) {
        super.init(frame: .zero)
        setupInfos(with: pixModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupInfos(with pixModel: PixCodeModel) {
        titleLabel.text = pixModel.title
        firstStepLabel.text = pixModel.firstStep
        codeLabel.text = pixModel.code
        copyCodeButton.setTitle(pixModel.buttonText, for: .normal)
        secondStepLabel.text = pixModel.secondStep
        thirdStepLabel.text = pixModel.thirdStep
        footerLabel.text = pixModel.footerText
    }
}
