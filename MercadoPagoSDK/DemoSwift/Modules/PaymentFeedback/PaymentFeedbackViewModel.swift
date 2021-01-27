//
//  PaymentFeedbackViewModel.swift
//  FeatureList
//
//  Created by Matheus Leandro Martins on 13/01/21.
//

final class PaymentFeedbackViewModel {
    //MARK: - Private properties
    private let dataSource: [PaymentFeedbackModel] = [
        PaymentFeedbackModel(title: "Standard", feedback: .standard(true)),
        PaymentFeedbackModel(title: "Standard with error", feedback: .standard(false)),
        PaymentFeedbackModel(title: "No points and no discounts", feedback: .noPointsNoDiscount),
        PaymentFeedbackModel(title: "Many instalments", feedback: .manyInstalments),
        PaymentFeedbackModel(title: "One instalment", feedback: .oneInstalment),
        PaymentFeedbackModel(title: "Consumer credits", feedback: .consumerCredits),
        PaymentFeedbackModel(title: "Consumer credits + instalments", feedback: .consumerCreditsPlusInstalments),
        PaymentFeedbackModel(title: "Account money", feedback: .moneyAccount),
        PaymentFeedbackModel(title: "Discount", feedback: .discount)
    ]
    
    //MARK: - Public methods
    func getNumberOfRows() -> Int {
        return dataSource.count
    }
    
    func getFeedbackTitle(at index: Int) -> String {
        return dataSource[index].title
    }
    
    func getFeedback(at index: Int) -> Feedback {
        dataSource[index].feedback
    }
}
