import Foundation

public protocol PXThreeDSProtocol: NSObjectProtocol {
    func authenticate(config: PXThreeDSConfig, cardTokenID: String, cardHolderName: String, paymentMethodId: String, purchaseAmount: String, currencyId: String, decimalPlaces: Int, decimalSeparator: String, thousandsSeparator: String, siteId: String, completion: @escaping (Swift.Result<Bool, Error>) -> Void)
}
