import Foundation
import MLCardDrawer

public struct PXOneTapDisplayInfo: Codable {
    let bottomDescription: PXText?
    let switchInfo: SwitchModel?
    let tag: PXText?

    enum CodingKeys: String, CodingKey {
        case bottomDescription = "bottom_description"
        case switchInfo = "switch"
        case tag
    }
}
