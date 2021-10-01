import Foundation

/**
 Use this protocol to implement Biometric validation
 */
@objc public protocol PXBiometricProtocol: NSObjectProtocol {
    func validate(config: PXBiometricConfig, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void)
    func isValidationRequired(config: PXBiometricConfig) -> Bool
}
