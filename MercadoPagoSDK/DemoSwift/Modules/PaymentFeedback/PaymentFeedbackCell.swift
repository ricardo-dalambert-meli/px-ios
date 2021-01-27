//
//  PaymentFeedbackCell.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 13/01/21.
//

import UIKit

final class PaymentFeedbackCell: UITableViewCell {
    private let feedback: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    //MARK: - Public methods
    func setupInfos(feedback: String) {
        self.feedback.text = feedback
        setupViewConfiguration()
    }
}

//MARK: - ViewConfiguration
extension PaymentFeedbackCell: ViewConfiguration {
    func buildHierarchy() {
         addSubviews(views: [feedback])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //featureName
            feedback.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            feedback.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            feedback.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            feedback.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
        selectionStyle = .none
    }
}


