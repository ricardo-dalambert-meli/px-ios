import Foundation

public struct PXBenefits: Codable {
    let installmentsHeader: PXText?
    let interestFree: PXInstallmentsConfiguration?
    let reimbursement: PXInstallmentsConfiguration?

    enum CodingKeys: String, CodingKey {
        case installmentsHeader = "installments_header"
        case interestFree = "interest_free"
        case reimbursement
    }
}
