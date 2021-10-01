import Foundation

struct PXExperiment: Codable {
    let id: Int
    let name: String
    let variant: PXVariant
}

// MARK: Tracking
extension PXExperiment {
    func getTrackingData() -> String {
        return "\(name) - \(variant.name)"
    }

    static func getExperimentsForTracking(_ experiments: [PXExperiment]) -> String {
        var experimentsString = ""
        for (index, exp) in experiments.enumerated() {
            experimentsString.append(exp.getTrackingData())

            if index != experiments.endIndex - 1 {
                experimentsString.append(",")
            }
        }
        return experimentsString
    }
}
