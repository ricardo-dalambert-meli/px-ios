import UIKit

class AddCardFlowModel: NSObject, PXFlowModel {
    enum Steps: Int {
        case start
        case finish
    }

    func nextStep() -> AddCardFlowModel.Steps {
        return .finish
    }
}
