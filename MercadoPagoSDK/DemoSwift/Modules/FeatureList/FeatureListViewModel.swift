//
//  FeatureListViewModel.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 12/01/21.
//

final class FeatureListViewModel {
    //MARK: - Private properties
    private let dataSource: [FeatureListModel] = [
        FeatureListModel(featureName: "Checkout: Standard", requirements: nil, feature: .standardCheckout),
        FeatureListModel(featureName: "Checkout: Processadora custom", requirements: nil, feature: .customProcesadora),
        FeatureListModel(featureName: "Checkout: Builder custom", requirements: nil, feature: .customBuilder),
        FeatureListModel(featureName: "Checkout: With charges", requirements: "User needs money on his account", feature: .withCharges),
        FeatureListModel(featureName: "Checkout: With charges and alert", requirements: "User needs money on his account", feature: .chargesWithAlert),
        FeatureListModel(featureName: "Checkout: No charges", requirements: "Has to have discount targeted oi a credit/ debit card", feature: .noCharges),
        FeatureListModel(featureName: "Checkout with parameters", requirements: nil, feature: .withParameters),
        FeatureListModel(featureName: "Payment feedback message", requirements: nil, feature: .paymentFeedback)
        
    ]
    
    private let userProfiles: [PickerUserProfileModel] = [
        PickerUserProfileModel(userProfile: "None user",
                               publicKey: "",
                               privateKey: ""),
        PickerUserProfileModel(userProfile: "Standard user",
                               publicKey: "TEST-e28d5a35-dece-45c9-9618-e8cc5dec6c42",
                               privateKey: "TEST-7169122440478352-062213-d23fa9fb38e4b3e94feee29864f0fae2-443064294")
    ]
    
    private var profileIndex = 0
    
    //MARK: - Public methods
    func getNumberOfCells() -> Int {
        return dataSource.count
    }
    
    func getFeatureInfos(index: Int) -> (String, String?) {
        return (dataSource[index].featureName, dataSource[index].requirements)
    }
    
    func getFeature(index: Int) -> Feature {
        return dataSource[index].feature
    }
    
    func getUserProfiles() -> [PickerUserProfileModel] {
        return userProfiles
    }
    
    func getCurrentUser() -> String {
        return userProfiles[profileIndex].userProfile
    }
    
    func updateProfileIndex(index: Int) {
        profileIndex = index
    }
    
    //TODO: Create a credentials file to add the information bellow and add to gitignore
    func getPreferenceId() -> String {
        return "656525290-5e361670-21ef-4509-8676-14a20f9e1937"
    }
    
    func getPublicKey() -> String {
        return userProfiles[profileIndex].publicKey
    }
    
    func getPrivateKey() -> String {
        return userProfiles[profileIndex].privateKey
    }
}
