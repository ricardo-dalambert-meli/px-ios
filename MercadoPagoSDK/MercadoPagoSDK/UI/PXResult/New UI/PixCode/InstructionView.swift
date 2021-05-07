//
//  PixCodeView.swift
//  AndesUI
//
//  Created by Matheus Leandro Martins on 22/04/21.
//

import UIKit

final class InstructionView: UIView {
    // MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_semiboldSystemFont(ofSize: 20)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_regularSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let codeBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_semiboldSystemFont(ofSize: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.45)
        label.textAlignment = .left
        return label
    }()
    
    private let copyCodeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 52, green: 131, blue: 250), for: .normal)
        return button
    }()
    
    private let stepsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()
    
    private let watchIcon: UIImageView = {
        let image = UIImageView()
        image.image = ResourceManager.shared.getImage("iconTime")
        return image
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_regularSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    // MARK: - Initialization
    init(instruction: PXInstruction) {
        super.init(frame: .zero)
        setupViewConfiguration()
        setupInfos(with: instruction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupInfos(with instruction: PXInstruction) {
        titleLabel.attributedText = instruction.subtitle?.htmlToAttributedString?.with(font: titleLabel.font)
        subtitleLabel.attributedText = instruction.interactions?.first?.title?.htmlToAttributedString?.with(font: subtitleLabel.font)
        codeLabel.text = instruction.interactions?.first?.content
        codeLabel.numberOfLines = 2
        copyCodeButton.setTitle(instruction.interactions?.first?.action?.label, for: .normal)
        
        instruction.interactions?.enumerated().forEach { index, interaction in
            if index == 0 { return }
            addVariableComponents(interaction: interaction)
        }
        
        footerLabel.attributedText = instruction.accreditationMessage?.htmlToAttributedString?.with(font: footerLabel.font)
    }
    
    private func addVariableComponents(interaction: PXInstructionInteraction) {
        if let title = interaction.title, let content = interaction.content, let action = interaction.action {
            let instructionLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont.ml_regularSystemFont(ofSize: 16)
                label.attributedText = title.htmlToAttributedString?.with(font: UIFont.ml_regularSystemFont(ofSize: 16))
                label.numberOfLines = 0
                return label
            }()
            
            let codeLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont.ml_semiboldSystemFont(ofSize: 16)
                label.textColor = UIColor.black.withAlphaComponent(0.45)
                label.textAlignment = .center
                label.text = content
                label.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
                label.layer.borderWidth = 1
                label.layer.cornerRadius = 6
                label.numberOfLines = 1
                return label
            }()
            
            let actionButton: UIButton = {
                let button = UIButton()
                button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: 14)
                button.setTitle(action.label, for: .normal)
                button.setTitleColor(UIColor(red: 52, green: 131, blue: 250), for: .normal)
                return button
            }()
            
            stepsStack.addArrangedSubviews(views: [instructionLabel, codeLabel, actionButton])
        } else if let title = interaction.title, let action = interaction.action {
            let instructionLabel: UILabel = {
                let label = UILabel()
                label.attributedText = title.htmlToAttributedString?.with(font: UIFont.ml_regularSystemFont(ofSize: 16))
                label.numberOfLines = 0
                return label
            }()
            
            let actionButton: UIButton = {
                let button = UIButton()
                button.titleLabel?.textAlignment = .left
                button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: 14)
                button.setTitle(action.label, for: .normal)
                button.setTitleColor(UIColor(red: 52, green: 131, blue: 250), for: .normal)
                return button
            }()

            stepsStack.addArrangedSubviews(views: [instructionLabel, actionButton])
        } else if let title = interaction.title {
            let instructionLabel: UILabel = {
                let label = UILabel()
                label.numberOfLines = 0
                return label
            }()
            instructionLabel.attributedText = title.htmlToAttributedString?.with(font: UIFont.ml_regularSystemFont(ofSize: 16))
            stepsStack.addArrangedSubviews(views: [instructionLabel])
        }
    }
}

extension InstructionView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [titleLabel, subtitleLabel, codeBorderView, copyCodeButton, stepsStack, watchIcon, footerLabel, separatorView])
        codeBorderView.addSubviews(views: [codeLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            codeBorderView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            codeBorderView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            codeBorderView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            codeLabel.topAnchor.constraint(equalTo: codeBorderView.topAnchor, constant: 16),
            codeLabel.leadingAnchor.constraint(equalTo: codeBorderView.leadingAnchor, constant: 16),
            codeLabel.trailingAnchor.constraint(equalTo: codeBorderView.trailingAnchor, constant: -16),
            codeLabel.bottomAnchor.constraint(equalTo: codeBorderView.bottomAnchor, constant: -16),
            
            copyCodeButton.topAnchor.constraint(equalTo: codeBorderView.bottomAnchor, constant: 6),
            copyCodeButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            copyCodeButton.heightAnchor.constraint(equalToConstant: 18),
            
            stepsStack.topAnchor.constraint(equalTo: copyCodeButton.bottomAnchor, constant: 18),
            stepsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stepsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            watchIcon.centerYAnchor.constraint(equalTo: footerLabel.centerYAnchor),
            watchIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            watchIcon.heightAnchor.constraint(equalToConstant: 16),
            watchIcon.widthAnchor.constraint(equalToConstant: 16),
            
            footerLabel.topAnchor.constraint(equalTo: stepsStack.bottomAnchor, constant: 24),
            footerLabel.leadingAnchor.constraint(equalTo: watchIcon.trailingAnchor, constant: 8),
            footerLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            separatorView.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 24),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}
