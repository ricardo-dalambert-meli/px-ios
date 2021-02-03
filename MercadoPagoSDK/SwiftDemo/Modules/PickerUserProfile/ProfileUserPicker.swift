//
//  ProfileUserPicker.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 15/01/21.
//

import UIKit


protocol ProfileUserPickerDelegate: class {
    func didClosePickerView(profileIndex: Int)
    func didChange(userPofile: String)
}

final class ProfileUserPicker: UIView {
    //MARK: - Private properties
    private let userProfiles: [PickerUserProfileModel]
    
    private let picker = UIPickerView()
    
    private var profileIndex = 0
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private weak var delegate: ProfileUserPickerDelegate?
    
    //MARK: - Initialization
    init(delegate: ProfileUserPickerDelegate, userProfiles: [PickerUserProfileModel]) {
        self.delegate = delegate
        self.userProfiles = userProfiles
        super.init(frame: .zero)
        setupViewConfiguration()
        picker.dataSource = self
        picker.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    @objc private func closePickerView() {
        delegate?.didClosePickerView(profileIndex: profileIndex)
        delegate?.didChange(userPofile: userProfiles[profileIndex].userProfile)
        removeFromSuperview()
    }
}

//MARK: - ViewConfiguration
extension ProfileUserPicker: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [picker, closeButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            
            picker.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
            picker.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
        closeButton.addTarget(self, action: #selector(closePickerView), for: .touchUpInside)
    }
}

//MARK: - UIPickerViewDataSource
extension ProfileUserPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userProfiles.count
    }
}

//MARK: - UIPickerViewDelegate
extension ProfileUserPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userProfiles[row].userProfile
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        profileIndex = row
    }
}
