//
//  PixCodeView.swift
//  AndesUI
//
//  Created by Matheus Leandro Martins on 22/04/21.
//

import UIKit

final class InstructionView: UIView {
    // MARK: - Private properties
    private weak var delegate: InstructionActionDelegate?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_semiboldSystemFont(ofSize: 20)
        return label
    }()
    
    private let stepsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16
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
    
    // MARK: - Initialization
    init(instruction: PXInstruction, delegate: InstructionActionDelegate?) {
        self.delegate = delegate
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
        
        instruction.interactions?.forEach { interaction in
            addVariableComponents(interaction: interaction)
        }
        
        footerLabel.attributedText = instruction.accreditationMessage?.htmlToAttributedString?.with(font: footerLabel.font)
    }
    
    private func addVariableComponents(interaction: PXInstructionInteraction) {
        if let _ = interaction.title, let _ = interaction.content, let _ = interaction.action {
            stepsStack.addArrangedSubviews(views: [InstructionActionView(instruction: interaction, delegate: self)])
        } else if let title = interaction.title {
            let instructionLabel: UILabel = {
                let label = UILabel()
                label.attributedText = title.htmlToAttributedString?.with(font: UIFont.ml_regularSystemFont(ofSize: 16))
                label.numberOfLines = 0
                return label
            }()
            
            stepsStack.addArrangedSubviews(views: [instructionLabel])
        }
    }
}

extension InstructionView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [titleLabel, stepsStack, watchIcon, footerLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            stepsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            stepsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stepsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            watchIcon.centerYAnchor.constraint(equalTo: footerLabel.centerYAnchor),
            watchIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            watchIcon.heightAnchor.constraint(equalToConstant: 16),
            watchIcon.widthAnchor.constraint(equalToConstant: 16),
            
            footerLabel.topAnchor.constraint(equalTo: stepsStack.bottomAnchor, constant: 24),
            footerLabel.leadingAnchor.constraint(equalTo: watchIcon.trailingAnchor, constant: 8),
            footerLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}

extension InstructionView: InstructionActionDelegate {
    func didTapOnActionButton(action: PXInstructionAction?) {
        delegate?.didTapOnActionButton(action: action)
    }
}
