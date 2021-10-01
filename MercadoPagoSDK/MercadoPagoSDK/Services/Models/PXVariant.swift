import Foundation

struct PXVariant: Codable {
    let id: Int
    let name: String
    let availableFeatures: [PXAvailableFeatures]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case availableFeatures = "available_features"
    }
}
