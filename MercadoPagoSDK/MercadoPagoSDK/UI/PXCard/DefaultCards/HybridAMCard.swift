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
    var cardBackgroundColor: UIColor
    var securityCodeLocation: MLCardSecurityCodeLocation = .back
    var defaultUI = false
    var securityCodePattern = 3
    var fontType: String = "light"
    var ownOverlayImage: UIImage? = UIImage()
    var ownGradient: CAGradientLayer
    
    
    init(_ isDisabled: Bool) {
        let backgroundColor = isDisabled ? UIColor(red: 204 / 255, green: 204 / 255, blue: 204 / 255, alpha: 1.0) : UIColor(red: 16 / 255, green: 24 / 255, blue: 32 / 255, alpha: 1.0)
        
        self.cardBackgroundColor = backgroundColor
        
        self.ownGradient = { () -> CAGradientLayer in
            let gradient = CAGradientLayer()
            
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.6, y: 0.5)

            gradient.colors = [backgroundColor.cgColor, backgroundColor.cgColor]
            
            return gradient
        }()
    }
    
}

extension HybridAMCard {
    static func render(containerView: UIView, isDisabled: Bool, size: CGSize) {
        // Image
        let amImage = UIImageView()
        amImage.backgroundColor = .clear
        amImage.contentMode = .scaleAspectFit
        let amImageRaw = ResourceManager.shared.getImage("hybridAmImage")
        amImage.image = amImageRaw
        amImage.alpha = 1
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
        amLogo.image = logoImage
        containerView.addSubview(amLogo)
        PXLayout.setWidth(owner: amLogo, width: size.width * 0.15).isActive = true
        PXLayout.setHeight(owner: amLogo, height: size.height * 0.15).isActive = true
        PXLayout.pinTop(view: amLogo, withMargin: PXLayout.M_MARGIN).isActive = true
        PXLayout.pinLeft(view: amLogo, withMargin: PXLayout.M_MARGIN).isActive = true
    }
}
