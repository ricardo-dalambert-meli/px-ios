import Foundation

protocol PXTermsAndConditionViewDelegate: NSObjectProtocol {
    func shouldOpenTermsCondition(_ title: String, url: URL)
}

extension PXTermsAndConditionViewDelegate where Self: UIViewController {
    func shouldOpenTermsCondition(_ title: String, url: URL) {
        let webVC = WebViewController(url: url, navigationBarTitle: title)
        webVC.title = title
        navigationController?.pushViewController(webVC, animated: true)
    }
}
