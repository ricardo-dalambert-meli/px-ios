import UIKit

struct PXLinkablePhraseDto: Codable {
    let textColor: String
    let phrase: String
    let link: String?
    let html: String?
    let installments: [String: String]?

    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case phrase
        case link
        case html
        case installments
    }
}
