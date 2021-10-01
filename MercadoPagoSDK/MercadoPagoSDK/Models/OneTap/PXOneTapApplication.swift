public struct PXApplicationPaymentMethod: Codable {
    var id: String?
    var type: String?
}

public struct PXApplicationValidationProgram: Codable {
    var id: String
    var mandatory: Bool
}

public struct PXOneTapApplication: Codable {
    var paymentMethod: PXApplicationPaymentMethod
    var validationPrograms: [PXApplicationValidationProgram]?
    var behaviours: [String: PXBehaviour]?
    var status: PXStatus

    public enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
        case validationPrograms = "validation_programs"
        case behaviours = "behaviours"
        case status = "status"
    }
}
