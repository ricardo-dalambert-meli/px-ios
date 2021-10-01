import Foundation

public struct PXBehaviour: Codable {
    let modal: String?
    let target: String?

    enum Behaviours: String {
        case startCheckout = "start_checkout"
        case switchSplit = "switch_split"
        case tapPay = "tap_pay"
        case tapCard = "tap_card"
    }
}
