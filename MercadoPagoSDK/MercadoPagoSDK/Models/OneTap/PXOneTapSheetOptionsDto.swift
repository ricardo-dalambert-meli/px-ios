import Foundation

open class PXOneTapSheetOptionsDto: NSObject, Codable {
    let cardFormInitType: String?
    let title: PXText
    let subtitle: PXText?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case cardFormInitType = "card_form_init_type"
        case title
        case subtitle
        case imageUrl = "image_url"
    }
}
