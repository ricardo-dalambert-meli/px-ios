//
//  PXOneTapHeaderMerchantView.swift
//  MercadoPagoSDK
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/10/18.
//

import UIKit

class PXOneTapHeaderMerchantView: UIStackView {
    let image: UIImage
    let title: String
    private var subTitle: String?
    private var showHorizontally: Bool
    private var layout: PXOneTapHeaderMerchantLayout
    private var imageView: PXUIImageView?
    private var merchantTitleLabel: UILabel?

    init(image: UIImage, title: String, subTitle: String? = nil, showHorizontally: Bool) {
        self.image = image
        self.title = title
        self.showHorizontally = showHorizontally
        self.subTitle = subTitle
        self.layout = PXOneTapHeaderMerchantLayout(layoutType: subTitle == nil ? .onlyTitle : .titleSubtitle)
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        render()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        
        let innerContainer = UIStackView()
        
        innerContainer.axis = showHorizontally ? .horizontal : .vertical
        innerContainer.alignment = showHorizontally ? .leading : .fill
        innerContainer.distribution = showHorizontally ? .fillProportionally : .fill
        
        self.addArrangedSubview(innerContainer)
        
        
        // Add the image of the merchant
        let imageContainerView = buildImageContainerView(image: image)
        innerContainer.addArrangedSubview(imageContainerView)
        
        let titleContainer = UIStackView()
        titleContainer.axis = .vertical
        
        titleContainer.alignment = showHorizontally ? .leading : .center
        
        // Add the title
        merchantTitleLabel = buildTitleLabel(text: title)
        if let titleLabel = merchantTitleLabel {
            titleContainer.addArrangedSubview(titleLabel)
        }
        
        // Add the subtitle
        if layout.getLayoutType() == .titleSubtitle {
            let subTitleLabel = buildSubTitleLabel(text: subTitle)
            titleContainer.addArrangedSubview(subTitleLabel)
        }
        
        innerContainer.addArrangedSubview(titleContainer)
        
        let emptyBottomSeparator = UIStackView()
        emptyBottomSeparator.axis = .vertical
        emptyBottomSeparator.heightAnchor.constraint(greaterThanOrEqualToConstant: 1.0).isActive = true
        self.addArrangedSubview(emptyBottomSeparator)
        
        self.layoutIfNeeded()

        isUserInteractionEnabled = true
    }

    private func buildImageContainerView(image: UIImage) -> UIView {
        let imageContainerView = UIStackView()
        imageContainerView.axis = .vertical
        imageContainerView.alignment = .center
        imageContainerView.distribution = .equalSpacing
        
        PXLayout.setHeight(owner: imageContainerView, height: layout.IMAGE_SIZE).isActive = true
        
        imageContainerView.dropShadow(radius: 2, opacity: 0.15)
        
        let imageView = PXUIImageView()
        
        imageView.layer.cornerRadius = layout.IMAGE_SIZE / 2
        
        PXLayout.setWidth(owner: imageView, width: layout.IMAGE_SIZE).isActive = true
        PXLayout.setHeight(owner: imageView, height: layout.IMAGE_SIZE).isActive = true
        imageView.enableFadeIn()
        imageView.backgroundColor = .white
        imageView.image = image
        imageContainerView.addArrangedSubview(imageView)
        
        self.imageView = imageView
        return imageContainerView
    }

    private func buildTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = text
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: PXLayout.M_FONT)
        titleLabel.textColor = ThemeManager.shared.statusBarStyle() == UIStatusBarStyle.default ? UIColor.black : ThemeManager.shared.whiteColor()
        titleLabel.textAlignment = .center
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return titleLabel
    }

    private func buildSubTitleLabel(text: String?) -> UILabel {
        let subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.text = text ?? ""
        subTitleLabel.numberOfLines = 1
        subTitleLabel.lineBreakMode = .byTruncatingTail
        subTitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        subTitleLabel.font = UIFont.ml_regularSystemFont(ofSize: PXLayout.XXXS_FONT)
        subTitleLabel.textColor = ThemeManager.shared.statusBarStyle() == UIStatusBarStyle.default ? UIColor.black : ThemeManager.shared.whiteColor()
        subTitleLabel.textAlignment = .center
        return subTitleLabel
    }
}

// MARK: Publics
extension PXOneTapHeaderMerchantView {
    func updateContentViewLayout(margin: CGFloat = PXLayout.M_MARGIN) {
        layoutIfNeeded()
    }

    func animateHeaderLayout(direction: OneTapHeaderAnimationDirection, duration: Double = 0) {
        layoutIfNeeded()
        var pxAnimator = PXAnimator(duration: duration, dampingRatio: 1)
        pxAnimator.addAnimation(animation: { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
        })

        pxAnimator.animate()
    }

    func getMerchantTitleLabel() -> UILabel? {
        return merchantTitleLabel
    }
}
