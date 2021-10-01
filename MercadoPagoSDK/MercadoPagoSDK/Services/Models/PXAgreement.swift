import UIKit

/**
 Support for gateway mode
 */

@objcMembers
open class PXAgreement: Codable {
    let merchantAccounts: [PXMerchantAccount]
    enum CodingKeys: String, CodingKey {
        case merchantAccounts = "merchant_accounts"
    }
}
