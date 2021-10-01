import Foundation

@objc
internal protocol PXCardInformationForm: NSObjectProtocol {

    func getCardBin() -> String?

    func getCardLastForDigits() -> String

    func isIssuerRequired() -> Bool

    func canBeClone() -> Bool
}
