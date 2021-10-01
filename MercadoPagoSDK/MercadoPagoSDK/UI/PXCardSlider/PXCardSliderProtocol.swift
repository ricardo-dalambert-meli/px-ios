import Foundation

protocol PXCardSliderProtocol: NSObjectProtocol {
    func newCardDidSelected(targetModel: PXCardSliderViewModel, forced: Bool)
    func cardDidTap(status: PXStatus)
    func didScroll(offset: CGPoint)
    func didEndDecelerating()
    func addNewCardDidTap()
    func addNewOfflineDidTap()
    func didEndScrollAnimation()
}
