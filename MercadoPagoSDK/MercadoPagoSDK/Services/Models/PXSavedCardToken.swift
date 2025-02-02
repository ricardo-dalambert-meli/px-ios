import Foundation
/// :nodoc:
open class PXSavedCardToken: PXCardToken {

    open var cardId: String
    open var securityCodeRequired: Bool = true

    public init(cardId: String, securityCode: String) {
        self.cardId = cardId
        super.init()
        self.securityCode = securityCode
        self.requireESC = false
    }

    internal init(cardId: String) {
        self.cardId = cardId
        super.init()
        self.device = PXDevice()
        self.requireESC = false
    }

    internal init(card: PXCardInformation, securityCode: String?, securityCodeRequired: Bool) {
        self.cardId = card.getCardId()
        super.init()
        self.securityCode = securityCode
        self.securityCodeRequired = securityCodeRequired
        self.device = PXDevice()
        self.requireESC = false
    }

    public enum PXSavedCardTokenKeys: String, CodingKey {
        case cardId = "card_id"
        case securityCode = "security_code"
        case device
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PXSavedCardTokenKeys.self)
        try container.encodeIfPresent(self.cardId, forKey: .cardId)
        try container.encodeIfPresent(self.securityCode, forKey: .securityCode)
        try container.encodeIfPresent(self.device, forKey: .device)
    }

    open override func toJSONString() throws -> String? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8)
    }

    open override func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }

    open func validateCardId() -> Bool {
        return !String.isNullOrEmpty(cardId) && String.isDigitsOnly(cardId)
    }

    open func validateSecurityCodeNumbers() -> Bool {
        let isEmptySecurityCode: Bool = String.isNullOrEmpty(self.securityCode)
        return !isEmptySecurityCode && self.securityCode!.count >= 3 && self.securityCode!.count <= 4
    }

    @objc open override func isCustomerPaymentMethod() -> Bool {
        return true
    }
}
