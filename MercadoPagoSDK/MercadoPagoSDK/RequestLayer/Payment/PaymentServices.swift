//
//  PaymentServices.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 15/07/21.
//

protocol PaymentServices {
    func getInit(preferenceId: String?,
                 privateKey: String?,
                 body: Data?,
                 headers: [String: String]?,
                 completion: @escaping (Swift.Result<PXInitDTO, PXError>) -> Void)
}

final class PaymentServicesImpl: PaymentServices {
    // MARK: - Private properties
    private let service: Requesting<PaymentRequestInfos>

    // MARK: - Initialization
    init(service: Requesting<PaymentRequestInfos> = Requesting<PaymentRequestInfos>()) {
        self.service = service
    }

    // MARK: - Public methods
    func getInit(preferenceId: String?, privateKey: String?, body: Data?, headers: [String: String]?, completion: @escaping (Swift.Result<PXInitDTO, PXError>) -> Void) {
        service.requestObject(model: PXInitDTO.self, .getInit(preferenceId: preferenceId, privateKey: privateKey, body: body, headers: headers)) { apiResponse in
            switch apiResponse {
            case .success(let payment): completion(.success(payment))
            case .failure: completion(.failure(PXError(domain: ApiDomain.GET_REMEDY,
                                                       code: ErrorTypes.NO_INTERNET_ERROR,
                                                       userInfo: [
                                                        NSLocalizedDescriptionKey: "Hubo un error",
                                                        NSLocalizedFailureReasonErrorKey: "Verifique su conexión a internet e intente nuevamente"
                                                       ])
                                                )
                                        )
            }
        }
    }
}
