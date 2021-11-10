protocol CustomService {
    func getPointsAndDiscounts(data: Data?, parameters: CustomParametersModel, response: @escaping (Swift.Result<PXPointsAndDiscounts, Error>) -> Void)
    func resetESCCap(cardId:String, privateKey: String?, response: @escaping (Swift.Result<Void, PXError>) -> Void)
    func createPayment(privateKey: String?, publicKey: String, checkout_type: String?, data: Data?, header: [String : String]?, response: @escaping (Swift.Result<PXPayment, PXError>) -> Void)
}


final class CustomServiceImpl: CustomService {
    // MARK: - private properties
    private let service: Request<CustomRequestInfos>
    
    // MARK: - Initialization
    init(service: Request<CustomRequestInfos> = Request<CustomRequestInfos>()) {
        self.service = service
    }
    
    // MARK: - Public methods
    func getPointsAndDiscounts(data: Data?, parameters: CustomParametersModel, response: @escaping (Swift.Result<PXPointsAndDiscounts, Error>) -> Void) {
        service.requestObject(model: PXPointsAndDiscounts.self, .getCongrats(data: data, congratsModel: parameters)) { apiResponse in
            switch apiResponse {
            case .success(let congratsInfos): response(.success(congratsInfos))
            case .failure(let error): response(.failure(error))
            }
        }
    }
    
    func resetESCCap(cardId:String, privateKey: String?, response: @escaping (Swift.Result<Void, PXError>) -> Void) {
        guard let privateKey = privateKey else {
            response(.failure(PXError(domain: ApiDomain.RESET_ESC_CAP, code: ErrorTypes.API_UNKNOWN_ERROR, userInfo: ["message": "Missing key"])))
            return
        }
        service.requestData(target: .resetESCCap(cardId: cardId, privateKey: privateKey)) { apiResponse in
            switch apiResponse {
            case .success: response(.success(()))
            case .failure(let error): response(.failure(PXError(domain: ApiDomain.RESET_ESC_CAP, code: ErrorTypes.NO_INTERNET_ERROR, userInfo: ["message": error.localizedDescription])))
            }
        }
    }
    
    func createPayment(privateKey: String?, publicKey: String, checkout_type: String? ,data: Data?, header: [String : String]?, response: @escaping (Swift.Result<PXPayment, PXError>) -> Void) {
        service.requestObject(model: PXPayment.self, .createPayment(privateKey: privateKey, publicKey: publicKey, checkout_type: checkout_type, data: data, header: header)) { apiResponse in
            switch apiResponse {
            case .success(let payment): response(.success(payment))
            case .failure: response(.failure(PXError(domain: ApiDomain.CREATE_PAYMENT, code: ErrorTypes.API_UNKNOWN_ERROR, userInfo: ["message": "PAYMENT_ERROR"])))
            }
        }
    }
}
