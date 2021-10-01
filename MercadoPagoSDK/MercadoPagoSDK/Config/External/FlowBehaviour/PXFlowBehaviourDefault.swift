import Foundation

/**
 Default PX implementation of Flow Behaviour for public distribution. (No-trackings)
 */
final class PXFlowBehaviourDefault: NSObject, PXFlowBehaviourProtocol {
    func trackConversion() {}

    func trackConversion(result: PXResultKey) {}
}
