import UIKit

protocol ViewControllerProtocol: AnyObject {

}

class ViewController<View: UIView, InteractorProcotol>: UIViewController {
    let interactor: InteractorProcotol
    let customView: View
    
    init(customView: View, interactor: InteractorProcotol) {
        self.interactor = interactor
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: ViewControllerProtocol
extension ViewController: ViewControllerProtocol {

}
