//
//  FeatureListView.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 12/01/21.
//

import UIKit

final class FeatureListView: UIView {
    //MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
        
    private let showPickerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "iconArrowDown")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let picker: ProfileUserPicker
    
    //MARK: - Initialization
    init(
        delegate: UITableViewDelegate,
        dataSource: UITableViewDataSource,
        pickerDelegate: ProfileUserPickerDelegate,
        userProfiles: [PickerUserProfileModel]
    ) {
        picker = ProfileUserPicker(delegate: pickerDelegate, userProfiles: userProfiles)
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
        tableView.register(FeatureListCell.self, forCellReuseIdentifier: FeatureListCell.reuseIdentifier)
    }
    
    //MARK: - Public methods
    func reloadData() {
        tableView.reloadData()
    }
    
    func setSelectedProfile(userProfile: String) {
        titleLabel.text = userProfile
    }
    
    //MARK: - Private methods
    private func setupshowPickerButton() {
        showPickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    @objc private func showPicker() {
        addSubviews(views: [picker])
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - ViewConfiguration
extension FeatureListView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [titleLabel, showPickerButton,tableView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            showPickerButton.heightAnchor.constraint(equalToConstant: 24),
            showPickerButton.widthAnchor.constraint(equalToConstant: 24),
            showPickerButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            showPickerButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func additionalConfigurations() {
        setupshowPickerButton()
        backgroundColor = .white
    }
}
