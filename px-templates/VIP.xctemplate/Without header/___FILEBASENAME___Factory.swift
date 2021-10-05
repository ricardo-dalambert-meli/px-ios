import UIKit

enum ___FILEBASENAMEASIDENTIFIER___ {
    static func make() -> ViewController<___VARIABLE_productName:identifier___View, ___VARIABLE_productName:identifier___InteractorProtocol> {
        let view = ___VARIABLE_productName:identifier___View()
        let presenter = ___VARIABLE_productName:identifier___Presenter()
        let repository = ___VARIABLE_productName:identifier___Repository()
        let interactor = ___VARIABLE_productName:identifier___Interactor(presenter: presenter, repository: repository)
        let controller = ___VARIABLE_productName:identifier___ViewController(customView: view, interactor: interactor)
        
        presenter.controller = controller
        return controller
    }
}
