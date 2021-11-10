import Foundation
import MLUI

protocol PXOfflineMethodsViewControllerDelegate: class {
    func didEnableUI(enabled: Bool)
}

final class PXOfflineMethodsViewController: MercadoPagoUIViewController {

    let viewModel: PXOfflineMethodsViewModel
    var callbackConfirm: ((PXPaymentData, Bool) -> Void)
    let callbackFinishCheckout: (() -> Void)
    var finishButtonAnimation: (() -> Void)
    var callbackUpdatePaymentOption: ((PaymentMethodOption) -> Void)
    let timeOutPayButton: TimeInterval

    let tableView = UITableView(frame: .zero, style: .grouped)
    var loadingButtonComponent: PXWindowedAnimatedButton?
    var inactivityView: UIView?
    var inactivityViewAnimationConstraint: NSLayoutConstraint?

    weak var delegate: PXOfflineMethodsViewControllerDelegate?

    var userDidScroll = false
    
    private struct Constants {
        static let viewBorderWidth: CGFloat = 1.5
        static let viewCornerRadius: CGFloat = 10
    }

    init(viewModel: PXOfflineMethodsViewModel, callbackConfirm: @escaping ((PXPaymentData, Bool) -> Void), callbackUpdatePaymentOption: @escaping ((PaymentMethodOption) -> Void), finishButtonAnimation: @escaping (() -> Void), callbackFinishCheckout: @escaping (() -> Void)) {
        self.viewModel = viewModel
        self.callbackConfirm = callbackConfirm
        self.callbackUpdatePaymentOption = callbackUpdatePaymentOption
        self.finishButtonAnimation = finishButtonAnimation
        self.callbackFinishCheckout = callbackFinishCheckout
        self.timeOutPayButton = 15
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        render()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.showInactivityViewIfNecessary()
        }

        autoSelectPaymentMethodIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sheetViewController?.scrollView = tableView
        trackScreen(event: MercadoPagoUITrackingEvents.offlineMethodds(viewModel.getScreenTrackingProperties()))
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        trackAbortEvent()
    }

    func getTopInset() -> CGFloat {
        if #available(iOS 13.0, *) {
            return 0
        } else {
            return PXLayout.getStatusBarHeight()
        }
    }

    func render() {
        view.layer.borderWidth = Constants.viewBorderWidth
        view.layer.borderColor = UIColor.Andes.graySolid070.cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.Andes.white
        
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        
        if #available(iOS 12.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        let footerView = getFooterView()
        view.addSubview(footerView)

        //Footer view layout
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(PXOfflineMethodsCell.self, forCellReuseIdentifier: PXOfflineMethodsCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .init(top: 0, left: PXLayout.S_MARGIN, bottom: 0, right: PXLayout.S_MARGIN)
        tableView.separatorColor = UIColor.black.withAlphaComponent(0.1)
        tableView.backgroundColor = .white
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: PXLayout.L_MARGIN),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
        tableView.reloadData()

        //Inactivity View - rendered but hidden
        renderInactivityView(text: viewModel.getTitleForLastSection())
        view.bringSubviewToFront(footerView)
    }

    private func autoSelectPaymentMethodIfNeeded() {
        guard let indexPath = viewModel.selectedIndexPath else { return }
        selectPaymentMethodAtIndexPath(indexPath)
    }

    private func selectPaymentMethodAtIndexPath(_ indexPath: IndexPath) {
        viewModel.selectedIndexPath = indexPath
        PXFeedbackGenerator.selectionFeedback()

        if viewModel.selectedIndexPath != nil {
            loadingButtonComponent?.setEnabled()
        } else {
            loadingButtonComponent?.setDisabled()
        }

        if let selectedPaymentOption = viewModel.getSelectedOfflineMethod() {
            callbackUpdatePaymentOption(selectedPaymentOption)
        }
    }

    private func getBottomPayButtonMargin() -> CGFloat {
        let safeAreaBottomHeight = PXLayout.getSafeAreaBottomInset()
        if safeAreaBottomHeight > 0 {
            return PXLayout.XXS_MARGIN + safeAreaBottomHeight
        }

        if UIDevice.isSmallDevice() {
            return PXLayout.XS_MARGIN
        }

        return PXLayout.M_MARGIN
    }

    private func getFooterView() -> UIView {
        let footerContainer = UIView()
        footerContainer.translatesAutoresizingMaskIntoConstraints = false
        footerContainer.backgroundColor = .white

        var displayInfoLabel: UILabel?
        if let description = viewModel.getDisplayInfo()?.bottomDescription {
            displayInfoLabel = buildLabel()
            if let label = displayInfoLabel {
                label.text = description.message
                if let backgroundColor = description.backgroundColor {
                    label.backgroundColor = UIColor.fromHex(backgroundColor)
                }
                if let textColor = description.textColor {
                    label.textColor = UIColor.fromHex(textColor)
                }
                footerContainer.addSubview(label)
                NSLayoutConstraint.activate([
                    label.leadingAnchor.constraint(equalTo: footerContainer.leadingAnchor, constant: PXLayout.M_MARGIN),
                    label.trailingAnchor.constraint(equalTo: footerContainer.trailingAnchor, constant: -PXLayout.M_MARGIN),
                    label.topAnchor.constraint(equalTo: footerContainer.topAnchor, constant: PXLayout.S_MARGIN)
                ])
            }
        }

        let loadingButtonComponent = PXWindowedAnimatedButton(normalText: "Pagar".localized, loadingText: "Procesando tu pago".localized, retryText: "Reintentar".localized)
        self.loadingButtonComponent = loadingButtonComponent
        loadingButtonComponent.animationDelegate = self
        loadingButtonComponent.layer.cornerRadius = 4
        loadingButtonComponent.add(for: .touchUpInside, { [weak self] in
            guard let self = self else { return }
            self.confirmPayment()
        })
        loadingButtonComponent.setTitle("Pagar".localized, for: .normal)
        loadingButtonComponent.backgroundColor = ThemeManager.shared.getAccentColor()
        loadingButtonComponent.accessibilityIdentifier = "pay_button"
        loadingButtonComponent.setDisabled()

        footerContainer.addSubview(loadingButtonComponent)

        var topConstraint: NSLayoutConstraint
        if let label = displayInfoLabel {
            topConstraint = loadingButtonComponent.topAnchor.constraint(equalTo: label.bottomAnchor, constant: PXLayout.S_MARGIN)
        } else {
            topConstraint = loadingButtonComponent.topAnchor.constraint(equalTo: footerContainer.topAnchor, constant: PXLayout.S_MARGIN)
        }
        topConstraint.isActive = true

        NSLayoutConstraint.activate([
            loadingButtonComponent.bottomAnchor.constraint(greaterThanOrEqualTo: footerContainer.bottomAnchor, constant: -getBottomPayButtonMargin()),
            loadingButtonComponent.leadingAnchor.constraint(equalTo: footerContainer.leadingAnchor, constant: PXLayout.M_MARGIN),
            loadingButtonComponent.trailingAnchor.constraint(equalTo: footerContainer.trailingAnchor, constant: -PXLayout.M_MARGIN)
        ])

        PXLayout.setHeight(owner: loadingButtonComponent, height: PXLayout.XXL_MARGIN).isActive = true

        footerContainer.dropShadow()

        return footerContainer
    }

    private func buildLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.ml_semiboldSystemFont(ofSize: PXLayout.XXXS_FONT)
        return label
    }
}

// MARK: Inactivity view methods
extension PXOfflineMethodsViewController {
    func showInactivityView(animated: Bool = true) {
        self.inactivityView?.isHidden = false
        let animator = UIViewPropertyAnimator(duration: animated ? 0.3 : 0, dampingRatio: 1) {
            self.inactivityViewAnimationConstraint?.constant = -PXLayout.XS_MARGIN
            self.inactivityView?.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }

    func hideInactivityView(animated: Bool = true) {
        let animator = UIViewPropertyAnimator(duration: animated ? 0.3 : 0, dampingRatio: 1) {
            self.inactivityViewAnimationConstraint?.constant = PXLayout.M_MARGIN
            self.inactivityView?.alpha = 0
            self.view.layoutIfNeeded()
        }
        self.inactivityView?.isHidden = true
        animator.startAnimation()
    }

    func showInactivityViewIfNecessary() {
        if let inactivityView = inactivityView, inactivityView.isHidden, !userDidScroll, hasHiddenPaymentTypes() {
            showInactivityView()
        }
    }

    func hideInactivityViewIfNecessary() {
        if let inactivityView = inactivityView, !inactivityView.isHidden, userDidScroll, !hasHiddenPaymentTypes() {
            hideInactivityView()
        }
    }

    func hasHiddenPaymentTypes() -> Bool {
        guard let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows else {return false}

        let visibleRowsLastSection = indexPathsForVisibleRows.filter { (indexPath) -> Bool in
            return indexPath.section == viewModel.numberOfSections() - 1
        }

        return visibleRowsLastSection.isEmpty
    }

    func renderInactivityView(text: String?) {
        let viewHeight: CGFloat = 28
        let imageSize: CGFloat = 16
        let inactivityView = UIView()
        inactivityView.translatesAutoresizingMaskIntoConstraints = false
        inactivityView.backgroundColor = ThemeManager.shared.navigationBar().backgroundColor
        inactivityView.layer.cornerRadius = viewHeight/2

        view.addSubview(inactivityView)
        NSLayoutConstraint.activate([
            inactivityView.heightAnchor.constraint(equalToConstant: viewHeight),
            inactivityView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let bottomConstraint = inactivityView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -PXLayout.XS_MARGIN)
        bottomConstraint.isActive = true

        self.inactivityView = inactivityView
        self.inactivityViewAnimationConstraint = bottomConstraint

        let arrowImage = ResourceManager.shared.getImage("inactivity_indicator")?.imageWithOverlayTint(tintColor: ThemeManager.shared.navigationBar().getTintColor())
        let imageView = UIImageView(image: arrowImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: inactivityView.leadingAnchor, constant: PXLayout.XS_MARGIN),
            imageView.centerYAnchor.constraint(equalTo: inactivityView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.widthAnchor.constraint(equalToConstant: imageSize)
        ])

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ThemeManager.shared.navigationBar().getTintColor()
        label.font = UIFont.ml_regularSystemFont(ofSize: PXLayout.XXXS_FONT)
        label.text = text

        inactivityView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: PXLayout.XXS_MARGIN),
            label.trailingAnchor.constraint(equalTo: inactivityView.trailingAnchor, constant: -PXLayout.XS_MARGIN),
            label.topAnchor.constraint(equalTo: inactivityView.topAnchor, constant: PXLayout.XXS_MARGIN),
            label.bottomAnchor.constraint(equalTo: inactivityView.bottomAnchor, constant: -PXLayout.XXS_MARGIN)
        ])

        hideInactivityView(animated: false)
    }
}

// MARK: UITableViewDelegate & DataSource
extension PXOfflineMethodsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PXOfflineMethodsCell.identifier, for: indexPath) as? PXOfflineMethodsCell {
            let data = viewModel.dataForCellAt(indexPath)
            cell.render(data: data)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = viewModel.headerTitleForSection(section)
        let view = UIView()
        view.backgroundColor = UIColor.Andes.white
        view.layer.cornerRadius = Constants.viewCornerRadius
        
        if #available(iOS 12.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if title?.weight == nil {
            label.text = title?.message
            label.font = UIFont.ml_semiboldSystemFont(ofSize: PXLayout.M_FONT)
            label.textColor = UIColor.Andes.gray900
        } else {
            label.attributedText = title?.getAttributedString(fontSize: PXLayout.M_FONT)
        }

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PXLayout.S_MARGIN),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: PXLayout.S_MARGIN),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPaymentMethodAtIndexPath(indexPath)
        tableView.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        userDidScroll = true
        hideInactivityViewIfNecessary()
    }
}

// MARK: Payment Button animation delegate
@available(iOS 9.0, *)
extension PXOfflineMethodsViewController: PXAnimatedButtonDelegate {
    func shakeDidFinish() {
        displayBackButton()
        isUIEnabled(true)
        unsubscribeFromNotifications()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingButtonComponent?.backgroundColor = ThemeManager.shared.getAccentColor()
        })
    }

    func expandAnimationInProgress() {
    }

    func didFinishAnimation() {
        self.dismiss(animated: true, completion: { [weak self] in
            self?.loadingButtonComponent?.animatedView?.removeFromSuperview()
        })
        self.finishButtonAnimation()
    }

    func progressButtonAnimationTimeOut() {
        loadingButtonComponent?.showErrorToast(title: "review_and_confirm_toast_error".localized, actionTitle: nil, type: MLSnackbarType.error(), duration: .short, action: nil)
    }

    private func confirmPayment() {
        isUIEnabled(false)
        if viewModel.shouldValidateWithBiometric() {
            viewModel.validateWithBiometric(onSuccess: { [weak self] in
                DispatchQueue.main.async {
                    self?.doPayment()
                }
            }, onError: { [weak self] _ in
                // User abort validation or validation fail.
                self?.isUIEnabled(true)
                self?.trackEvent(event: GeneralErrorTrackingEvents.error([:]))
            })
        } else {
            doPayment()
        }
    }

    private func doPayment() {
        if shouldAnimateButton() {
            subscribeLoadingButtonToNotifications()
            loadingButtonComponent?.startLoading(timeOut: self.timeOutPayButton)
            disableModalDismiss()
        }

        if let selectedOfflineMethod = viewModel.getSelectedOfflineMethod(), let newPaymentMethod = viewModel.getOfflinePaymentMethod(targetOfflinePaymentMethod: selectedOfflineMethod) {
            let currentPaymentData: PXPaymentData = viewModel.amountHelper.getPaymentData()
            currentPaymentData.payerCost = nil
            currentPaymentData.paymentMethod = newPaymentMethod
            currentPaymentData.issuer = nil
            trackEvent(event: PXOfflineMethodsTrackingEvents.didConfirm(viewModel.getEventTrackingProperties(selectedOfflineMethod)))
            if let payerCompliance = viewModel.getPayerCompliance(), payerCompliance.offlineMethods.isCompliant {
                currentPaymentData.payer?.firstName = viewModel.getPayerFirstName()
                currentPaymentData.payer?.lastName = viewModel.getPayerLastName()
                currentPaymentData.payer?.identification = viewModel.getPayerIdentification()
            }
        }

        let splitPayment = false
        hideBackButton()
        hideNavBar()
        callbackConfirm(viewModel.amountHelper.getPaymentData(), splitPayment)

        if shouldShowKyC() {
            dismiss(animated: false, completion: nil)
            callbackFinishCheckout()
        }
    }

    func isUIEnabled(_ enabled: Bool) {
        delegate?.didEnableUI(enabled: enabled)
        tableView.isScrollEnabled = enabled
        view.isUserInteractionEnabled = enabled
        loadingButtonComponent?.isUserInteractionEnabled = enabled
    }

    private func shouldAnimateButton() -> Bool {
        return !shouldShowKyC()
    }

    private func shouldShowKyC() -> Bool {
        if let selectedOfflineMethod = viewModel.getSelectedOfflineMethod(), selectedOfflineMethod.hasAdditionalInfoNeeded,
            let compliant = viewModel.getPayerCompliance()?.offlineMethods.isCompliant, !compliant {
            return true
        }
        return false
    }

    private func disableModalDismiss() {
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }
}

// MARK: Notifications
extension PXOfflineMethodsViewController {
    func subscribeLoadingButtonToNotifications() {
        guard let loadingButton = loadingButtonComponent else {
            return
        }
        PXNotificationManager.SuscribeTo.animateButton(loadingButton, selector: #selector(loadingButton.animateFinish))
    }

    func unsubscribeFromNotifications() {
        PXNotificationManager.UnsuscribeTo.animateButton(loadingButtonComponent)
    }
}
