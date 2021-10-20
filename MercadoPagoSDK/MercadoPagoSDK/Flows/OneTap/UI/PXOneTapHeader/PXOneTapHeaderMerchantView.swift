import UIKit
import AndesUI

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
        self.layout = PXOneTapHeaderMerchantLayout(layoutType: subTitle == nil ? .onlyTitle : .titleSubtitle, showHorizontally: showHorizontally)
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        render()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        
        // Setup root StackView
        self.axis = .vertical
        self.alignment = showHorizontally ? .leading : .center
        self.distribution = showHorizontally ? .fill : .equalSpacing
        
        // If it shows vertically, then add top separator to center innerContainer
        if !showHorizontally {
            let emptyTopSeparator = UIStackView()
            emptyTopSeparator.axis = .vertical
            self.addArrangedSubview(emptyTopSeparator)
        }
        
        // Create inner container
        let innerContainer = UIStackView()

        innerContainer.axis = showHorizontally ? .horizontal : .vertical
        innerContainer.alignment = showHorizontally ? .center : .fill
        innerContainer.distribution = showHorizontally ? .equalSpacing : .fill
        
        innerContainer.spacing = 8
        
        // If showing horizontally add insets and spacing
        if showHorizontally {
            innerContainer.spacing = 16
            innerContainer.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            innerContainer.isLayoutMarginsRelativeArrangement = true
        }
        
        self.addArrangedSubview(innerContainer)

        // Add the image of the merchant
        let imageContainerView = buildImageContainerView(image: image)
        innerContainer.addArrangedSubview(imageContainerView)
        
        // Create title container
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
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = layout.IMAGE_SIZE / 2
        
        PXLayout.setWidth(owner: imageView, width: layout.IMAGE_SIZE).isActive = true
        PXLayout.setHeight(owner: imageView, height: layout.IMAGE_SIZE).isActive = true
        imageView.enableFadeIn()
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.Andes.gray070.cgColor
        imageView.image = image
        imageContainerView.addArrangedSubview(imageView)
        
        self.imageView = imageView
        return imageContainerView
    }

    private func buildTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: PXLayout.S_FONT)
        titleLabel.textColor = UIColor.Andes.gray900
        titleLabel.textAlignment = showHorizontally ? .left : .center

        return titleLabel
    }

    private func buildSubTitleLabel(text: String?) -> UILabel {
        let subTitleLabel = UILabel()
        subTitleLabel.text = text ?? ""
        subTitleLabel.numberOfLines = 1
        subTitleLabel.lineBreakMode = .byTruncatingTail
        subTitleLabel.font = UIFont.ml_regularSystemFont(ofSize: PXLayout.XXS_FONT)
        subTitleLabel.textColor = UIColor.Andes.gray900
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
