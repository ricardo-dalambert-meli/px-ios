//
//  ViewConfiguration.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 12/01/21.
//

import UIKit

protocol ViewConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func additionalConfigurations()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildHierarchy()
        setupConstraints()
        additionalConfigurations()
    }
    func additionalConfigurations() {}
}

//MARK: - UIView extensions
extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}

//MARK: - UIStackView extensions
extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
}

//MARK: - UITableViewCell
protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
extension UITableViewCell: Reusable { }

