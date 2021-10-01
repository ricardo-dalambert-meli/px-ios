import Foundation

/// :nodoc:
@objcMembers
open class PXSensitiveInformation: NSObject, Codable {
    let firstName: String
    let lastName: String
    let identification: PXIdentification

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case identification
    }
}
