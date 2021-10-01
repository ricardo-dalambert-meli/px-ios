import Foundation

public struct PXInstallmentsConfiguration: Codable {
    let appliedInstallments: [Int]
    let card: PXText?
    let installmentRow: PXText?

    enum CodingKeys: String, CodingKey {
        case appliedInstallments = "applied_installments"
        case card
        case installmentRow = "installment_row"
    }
}
