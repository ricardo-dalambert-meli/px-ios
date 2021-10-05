protocol PresenterProtocol {

}

class Presenter {
    weak var controller: ViewControllerProtocol?
}

// MARK: - PresenterProtocol
extension Presenter: PresenterProtocol {
    
}
