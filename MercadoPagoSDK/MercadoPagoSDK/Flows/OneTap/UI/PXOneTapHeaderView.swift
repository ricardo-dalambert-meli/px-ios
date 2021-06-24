//
//  PXOneTapHeaderView.swift
//  MercadoPagoSDK
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/10/18.
//

import UIKit

enum OneTapHeaderAnimationDirection: Int {
    case horizontal
    case vertical
}

class PXOneTapHeaderView: UIStackView {
    private var model: PXOneTapHeaderViewModel {
        willSet(newModel) {
            updateLayout(newModel: newModel, oldModel: model)
        }
    }

    internal weak var delegate: PXOneTapHeaderProtocol?
    private var isShowingHorizontally: Bool = false
    private var verticalLayoutConstraints: [NSLayoutConstraint] = []
    private var horizontalLayoutConstraints: [NSLayoutConstraint] = []
    private var merchantView: PXOneTapHeaderMerchantView?
    private var summaryView: PXOneTapSummaryView?
    private var splitPaymentView: PXOneTapSplitPaymentView?
    private var splitPaymentViewHeightConstraint: NSLayoutConstraint?
    private let splitPaymentViewHeight: CGFloat = 55
    private var emptyTotalRowBottomMarginConstraint: NSLayoutConstraint?

    init(viewModel: PXOneTapHeaderViewModel, delegate: PXOneTapHeaderProtocol?) {
        self.model = viewModel
        self.delegate = delegate
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.render()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateModel(_ model: PXOneTapHeaderViewModel) {
        self.model = model
    }

    func updateSplitPaymentView(splitConfiguration: PXSplitConfiguration?) {
        if let newSplitConfiguration = splitConfiguration {
            self.splitPaymentView?.update(splitConfiguration: newSplitConfiguration)
        }
    }
}

// MARK: Privates.
private extension PXOneTapHeaderView {

    func toggleSplitPaymentView(shouldShow: Bool, duration: Double = 0.5) {
        layoutIfNeeded()
        var pxAnimator = PXAnimator(duration: duration, dampingRatio: 1)
        pxAnimator.addAnimation(animation: { [weak self] in
            guard let self = self else { return }
            self.splitPaymentView?.isHidden = !shouldShow
        })

        pxAnimator.animate()
    }

    func shouldShowHorizontally(model: PXOneTapHeaderViewModel) -> Bool {
        return true
        
        if UIDevice.isLargeOrExtraLargeDevice() {
            if UIDevice.isLargeDevice(), model.splitConfiguration != nil, model.data.first(where: { $0.type == PXOneTapSummaryRowView.RowType.discount }) != nil {
                return true
            }
            //an extra large device will always be able to accomodate al view in vertical mode
            return false
        }
        if UIDevice.isSmallDevice() {
            //a small device will never be able to accomodate al view in vertical mode
            return true
        }
        // a regular device will collapse if combined rows result in a medium sized header or larger
        return model.hasMediumHeaderOrLarger()
    }

    func removeAnimations() {
        layer.removeAllAnimations()
        for view in self.arrangedSubviews {
            view.layer.removeAllAnimations()
        }
    }

    func updateLayout(newModel: PXOneTapHeaderViewModel, oldModel: PXOneTapHeaderViewModel) {
        removeAnimations()

        let animationDuration = 0.35
        let shouldAnimateSplitPaymentView = (newModel.splitConfiguration != nil) != (oldModel.splitConfiguration != nil)
        let shouldHideSplitPaymentView = newModel.splitConfiguration == nil
        let shouldShowHorizontally = self.shouldShowHorizontally(model: newModel)

        layoutIfNeeded()

        if shouldShowHorizontally, !isShowingHorizontally {
            //animate to horizontal
            animateHeaderLayout(direction: .horizontal, duration: animationDuration)
        } else if !shouldShowHorizontally, isShowingHorizontally {
            //animate to vertical
            animateHeaderLayout(direction: .vertical, duration: animationDuration)
        }

        layoutIfNeeded()

        summaryView?.updateSplitMoney(newModel.splitConfiguration != nil)
        summaryView?.update(newModel.data)

        if shouldAnimateSplitPaymentView {
            layoutIfNeeded()
            superview?.layoutIfNeeded()
            if shouldHideSplitPaymentView {
                toggleSplitPaymentView(shouldShow: false, duration: animationDuration)
            } else {
                toggleSplitPaymentView(shouldShow: true, duration: animationDuration)
            }
        }
    }

    func animateHeaderLayout(direction: OneTapHeaderAnimationDirection, duration: Double = 0) {
        isShowingHorizontally = (direction == .horizontal) ? true : false
        merchantView?.animateHeaderLayout(direction: direction, duration: duration)
        if (direction == .vertical) {
            let margin = model.splitConfiguration != nil ? PXLayout.ZERO_MARGIN : PXLayout.M_MARGIN
            merchantView?.updateContentViewLayout(margin: margin)
        }

        var pxAnimator = PXAnimator(duration: duration, dampingRatio: 1)
        pxAnimator.addAnimation(animation: { [weak self] in
            guard let self = self else { return }

            for constraint in self.horizontalLayoutConstraints.reversed() {
                constraint.isActive = (direction == .horizontal)
            }

            for constraint in self.verticalLayoutConstraints.reversed() {
                constraint.isActive = (direction == .vertical)
            }
            self.layoutIfNeeded()
        })

        pxAnimator.animate()
    }
    
    func render() {
        removeAllSubviews()
        
        backgroundColor = ThemeManager.shared.navigationBar().backgroundColor

        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        
        // Add MerchantView
        let merchantView = PXOneTapHeaderMerchantView(image: model.icon, title: model.title, subTitle: model.subTitle, showHorizontally: true)

        let headerTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap))
        merchantView.addGestureRecognizer(headerTapGesture)

        self.merchantView = merchantView
        self.addArrangedSubview(merchantView)

        PXLayout.matchWidth(ofView: merchantView).isActive = true
        PXLayout.centerHorizontally(view: merchantView).isActive = true
        
        merchantView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50.0).isActive = true
        
//        // Add empty spacing view
//        let spacingView = UIStackView()
//        spacingView.axis = .vertical
//        addArrangedSubview(spacingView)
//
//        PXLayout.matchWidth(ofView: spacingView).isActive = true
//        PXLayout.centerHorizontally(view: spacingView).isActive = true
//
//        spacingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1.0).isActive = true
        
        // Add Summary
        let summaryView = PXOneTapSummaryView(data: model.data, delegate: self, splitMoney: model.splitConfiguration != nil)
        
        self.summaryView = summaryView

        addArrangedSubview(summaryView)
        
        PXLayout.matchWidth(ofView: summaryView).isActive = true
        PXLayout.centerHorizontally(view: summaryView).isActive = true
        
        summaryView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1.0).isActive = true
        
        // Add SplitPaymentView
        let splitPaymentView = PXOneTapSplitPaymentView(splitConfiguration: model.splitConfiguration) { (isOn, isUserSelection) in
            self.delegate?.splitPaymentSwitchChangedValue(isOn: isOn, isUserSelection: isUserSelection)
        }

        self.splitPaymentView = splitPaymentView

        addArrangedSubview(splitPaymentView)
        PXLayout.matchWidth(ofView: splitPaymentView).isActive = true

    }

//    func render() {
//        removeAllSubviews()
////        removeMargins()
//        backgroundColor = ThemeManager.shared.navigationBar().backgroundColor
//
//        self.axis = .vertical
//        self.alignment = .fill
//        self.distribution = .fill
//
//        let summaryView = PXOneTapSummaryView(data: model.data, delegate: self, splitMoney: model.splitConfiguration != nil)
//        self.summaryView = summaryView
//
//        addArrangedSubview(summaryView)
//        PXLayout.matchWidth(ofView: summaryView).isActive = true
//
//        let splitPaymentView = PXOneTapSplitPaymentView(splitConfiguration: model.splitConfiguration) { (isOn, isUserSelection) in
//            self.delegate?.splitPaymentSwitchChangedValue(isOn: isOn, isUserSelection: isUserSelection)
//        }
//        self.splitPaymentView = splitPaymentView
//        addArrangedSubview(splitPaymentView)
//        PXLayout.matchWidth(ofView: splitPaymentView).isActive = true
//
//        let initialSplitPaymentViewHeight = model.splitConfiguration != nil ? self.splitPaymentViewHeight : 0
//        self.splitPaymentViewHeightConstraint = PXLayout.setHeight(owner: splitPaymentView, height: initialSplitPaymentViewHeight)
//        self.splitPaymentViewHeightConstraint?.isActive = true
//        PXLayout.centerHorizontally(view: splitPaymentView).isActive = true
//        PXLayout.pinBottom(view: splitPaymentView).isActive = true
//        PXLayout.put(view: splitPaymentView, onBottomOf: summaryView).isActive = true
//
//        let showHorizontally = shouldShowHorizontally(model: model)
//        let merchantView = PXOneTapHeaderMerchantView(image: model.icon, title: model.title, subTitle: model.subTitle, showHorizontally: showHorizontally)
//
//        let headerTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap))
//        merchantView.addGestureRecognizer(headerTapGesture)
//
//        self.merchantView = merchantView
//        self.addArrangedSubview(merchantView)
//
//        let bestRelation = PXLayout.put(view: merchantView, aboveOf: summaryView, withMargin: -PXLayout.M_MARGIN)
//        bestRelation.priority = UILayoutPriority(rawValue: 900)
//        let minimalRelation = PXLayout.put(view: merchantView, aboveOf: summaryView, withMargin: -PXLayout.XXS_MARGIN, relation: .greaterThanOrEqual)
//        minimalRelation.priority = UILayoutPriority(rawValue: 1000)
//
//        let horizontalConstraints = [PXLayout.pinTop(view: merchantView, withMargin: -PXLayout.XXL_MARGIN),
//                                     bestRelation, minimalRelation,
//                                     PXLayout.centerHorizontally(view: merchantView),
//                                     PXLayout.matchWidth(ofView: merchantView)]
//
//        self.horizontalLayoutConstraints.append(contentsOf: horizontalConstraints)
//
//        let verticalLayoutConstraints = [PXLayout.pinTop(view: merchantView),
//                                         PXLayout.put(view: merchantView, aboveOf: summaryView, relation: .greaterThanOrEqual),
//                                         PXLayout.centerHorizontally(view: merchantView),
//                                         PXLayout.matchWidth(ofView: merchantView)]
//
//        self.verticalLayoutConstraints.append(contentsOf: verticalLayoutConstraints)
//
//        if showHorizontally {
//            animateHeaderLayout(direction: .horizontal)
//        } else {
//            animateHeaderLayout(direction: .vertical)
//        }
//    }
}

extension PXOneTapHeaderView: PXOneTapSummaryProtocol {
    func didTapCharges() {
        delegate?.didTapCharges()
    }

    func didTapDiscount() {
        delegate?.didTapDiscount()
    }

    @objc func handleHeaderTap() {
        delegate?.didTapMerchantHeader()
    }
}

// MARK: Publics
extension PXOneTapHeaderView {
    func getMerchantView() -> PXOneTapHeaderMerchantView? {
        return merchantView
    }

    func updateConstraintsIfNecessary() {
        summaryView?.updateRowsConstraintsIfNecessary()
    }
}
