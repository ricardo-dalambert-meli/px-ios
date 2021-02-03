//
//  PaymentFeedbackView.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 13/01/21.
//

import UIKit

final class PaymentFeedbackView: UIView {
    //MARK: - Private properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Initialization
    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        setupTableView(delegate: delegate, dataSource: dataSource)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(PaymentFeedbackCell.self, forCellReuseIdentifier: PaymentFeedbackCell.reuseIdentifier)
    }
    
    //MARK: - Public methods
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - ViewConfiguration
extension PaymentFeedbackView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [tableView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
    }
}

