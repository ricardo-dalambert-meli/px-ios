import UIKit

struct PXResultInfo: Codable {
    let title: String?
    let subtitle: String?

    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
    }
}
