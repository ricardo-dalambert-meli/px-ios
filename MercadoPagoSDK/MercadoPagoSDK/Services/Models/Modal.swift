import Foundation

struct Modal: Codable {
    let title: PXText
    let description: PXText
    let mainButton: ModalAction
    let secondaryButton: ModalAction
}

struct ModalAction: Codable {
    let label: String
    let action: String
    let type: String
}
