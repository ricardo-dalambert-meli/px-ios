//
//  FeatureListCell.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 12/01/21.
//

import UIKit

final class FeatureListCell: UITableViewCell {
    private let featureName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    //MARK: - Public methods
    func setupInfos(featureName: String, requirement: String?) {
        self.featureName.text = "\(featureName) \(requirement ?? "")"
        setupViewConfiguration()
    }
}

//MARK: - ViewConfiguration
extension FeatureListCell: ViewConfiguration {
    func buildHierarchy() {
         addSubviews(views: [featureName])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //featureName
            featureName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            featureName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            featureName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            featureName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
        selectionStyle = .none
    }
}

