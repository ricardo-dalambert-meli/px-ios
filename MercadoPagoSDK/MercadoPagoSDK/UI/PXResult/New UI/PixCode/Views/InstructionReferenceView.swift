//
//  InstructionReferenceView.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 14/05/21.
//

import UIKit

final class InstructionReferenceView: UIView {
    // MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_mediumSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ml_lightSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private let secondaryInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Initialization
    init(reference: PXInstructionReference) {
        super.init(frame: .zero)
        setupInfos(with: reference)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private mmethods
    private func setupInfos(with reference: PXInstructionReference) {
        titleLabel.text = reference.label
        infoLabel.text = reference.getFullReferenceValue()
    }
}

extension InstructionReferenceView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [titleLabel, infoLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
