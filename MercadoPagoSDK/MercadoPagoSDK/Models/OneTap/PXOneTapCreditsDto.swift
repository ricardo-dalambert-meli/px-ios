import UIKit

/// :nodoc:
public struct PXOneTapCreditsDto: Codable {
    let displayInfo: PXDisplayInfoDto
    enum CodingKeys: String, CodingKey {
        case displayInfo = "display_info"
    }
}
