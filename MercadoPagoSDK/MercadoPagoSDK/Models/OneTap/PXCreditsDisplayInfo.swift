import UIKit

/// :nodoc:
public struct PXPaymentMethodDisplayInfo: Codable {
    let resultInfo: PXResultInfo?
    let termsAndConditions: PXTermsDto?
    let description: PXText?
    let cvvInfo: PXCVVInfo?

    enum CodingKeys: String, CodingKey {
        case resultInfo = "result_info"
        case termsAndConditions = "terms_and_conditions"
        case description
        case cvvInfo = "cvv_info"
    }
}
