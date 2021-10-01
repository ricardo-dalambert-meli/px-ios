import UIKit

class PXLoadingViewController: UIViewController {
    override func viewDidLoad() {
        _ = PXComponentFactory.Loading.instance().showInView(view)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = ThemeManager.shared.statusBarStyle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
}
