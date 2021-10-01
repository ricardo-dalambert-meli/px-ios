import Foundation

final class PXInitConfigurations: Codable {
    let ESCBlacklistedStatus: [String]?

    enum CodingKeys: String, CodingKey {
        case ESCBlacklistedStatus = "esc_blacklisted_status"
    }
}
