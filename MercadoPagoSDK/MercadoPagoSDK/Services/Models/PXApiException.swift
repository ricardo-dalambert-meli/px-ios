import Foundation
/// :nodoc:
open class PXApiException: NSObject, Codable {
    open var cause: [PXCause]?
    open var error: String?
    open var message: String?
    open var status: Int?
}
