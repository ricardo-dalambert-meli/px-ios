import Foundation

/// :nodoc:
@objcMembers
open class PXPayerCompliance: NSObject, Codable {
    let offlineMethods: PXOfflineMethodsCompliance
    let ifpe: PXIfpe?

    enum CodingKeys: String, CodingKey {
        case offlineMethods = "offline_methods"
        case ifpe
    }
}
