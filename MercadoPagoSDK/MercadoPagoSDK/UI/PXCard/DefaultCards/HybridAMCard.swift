//
//  HybridAMCard.swift
//  MercadoPagoSDK
//
//  Created by Jonathan Scaramal on 11/11/2020.
//

import Foundation
import MLCardDrawer

class HybridAMCard: NSObject, CustomCardDrawerUI {
    var placeholderName = ""
    var placeholderExpiration = ""
    var bankImage: UIImage?
    var cardPattern = [0]
    var cardFontColor: UIColor = UIColor(red: 105 / 255, green: 105 / 255, blue: 105 / 255, alpha: 1)
    var cardLogoImage: UIImage?
    var cardBackgroundColor: UIColor = UIColor(red: 0.16, green: 0.24, blue: 0.32, alpha: 1.0)
    var securityCodeLocation: MLCardSecurityCodeLocation = .back
    var defaultUI = false
    var securityCodePattern = 3
    var fontType: String = "light"
    var ownOverlayImage: UIImage? = UIImage()
    var ownGradient = CAGradientLayer()
    
}

extension HybridAMCard {
    static func render(containerView: UIView, isDisabled: Bool, size: CGSize) {
        // Gradient
        
        // Image
        let amImage = UIImageView()
        amImage.backgroundColor = .clear
        amImage.contentMode = .scaleAspectFit
        let amImageRaw = ResourceManager.shared.getImage("hybridAmImage")
        amImage.image = isDisabled ? amImageRaw?.imageGreyScale() : amImageRaw
        amImage.alpha = 0.6
        containerView.addSubview(amImage)
        PXLayout.setWidth(owner: amImage, width: size.height).isActive = true
        PXLayout.setHeight(owner: amImage, height: size.height).isActive = true
        PXLayout.pinTop(view: amImage).isActive = true
        PXLayout.pinRight(view: amImage).isActive = true

        // Pattern
//        if !isDisabled {
//            let patternView = UIImageView()
//            patternView.contentMode = .scaleAspectFit
//            patternView.image = ResourceManager.shared.getImage("hybridAmPattern")
//            containerView.addSubview(patternView)
//
//            let height = size.height
//            let width = height * 1.1
//
//            PXLayout.setHeight(owner: patternView, height: height).isActive = true
//            PXLayout.setWidth(owner: patternView, width: width).isActive = true
//            PXLayout.pinTop(view: patternView).isActive = true
//            PXLayout.pinRight(view: patternView).isActive = true
//        }

        // Logo
        let amLogo = UIImageView()
        amLogo.backgroundColor = .clear
        amLogo.contentMode = .scaleAspectFit
        let logoImage = ResourceManager.shared.getImage("hybridAmLogo")
        amLogo.image = isDisabled ? logoImage?.imageGreyScale() : logoImage
        containerView.addSubview(amLogo)
        PXLayout.setWidth(owner: amLogo, width: size.height * 0.6 * 0.5).isActive = true
        PXLayout.setHeight(owner: amLogo, height: size.height * 0.35 * 0.5).isActive = true
        PXLayout.pinTop(view: amLogo, withMargin: PXLayout.M_MARGIN).isActive = true
        PXLayout.pinLeft(view: amLogo, withMargin: PXLayout.M_MARGIN).isActive = true
    }
}
