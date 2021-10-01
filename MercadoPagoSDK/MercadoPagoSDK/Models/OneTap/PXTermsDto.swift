import UIKit

/// :nodoc:
public struct PXTermsDto: Codable {
    let text: String
    let textColor: String?
    let linkablePhrases: [PXLinkablePhraseDto]?
    let links: [String: String]?

    enum CodingKeys: String, CodingKey {
        case text
        case textColor = "text_color"
        case linkablePhrases = "linkable_phrases"
        case links
    }
}
