//
//  PXCardSliderSizeManager.swift
//
//  Created by Juan sebastian Sanzone on 12/10/18.
//

import UIKit
import MLCardDrawer

struct PXCardSliderSizeManager {

    static let goldenRatio: CGFloat = 1/1.586
    static let interItemSpace: CGFloat = 16
    static let cardDeltaDecrease: CGFloat = 60
    
    // Card type ratios
    static let smallRatio : CGFloat = 0.328
    static let mediumRatio : CGFloat = 0.492
    static let largeRatio : CGFloat = 0.61
    
    static func aspectRatio(forType type: MLCardDrawerType) -> CGFloat {
        switch type {
        case .small:
         return smallRatio
        case .medium:
         return mediumRatio
        case .large:
         return largeRatio
        }
    }

    static func getCGSizeWithAspectRatioFor(_ width: CGFloat, _ type: MLCardDrawerType = .large) -> CGSize {
        return CGSize(width: width, height: width * aspectRatio(forType: type))
    }

    static func getHeaderViewHeight(viewController: UIViewController) -> CGFloat {
        if UIDevice.isSmallDevice() {
            return PXLayout.getAvailabelScreenHeight(in: viewController, applyingMarginFactor: 38)
        } else if UIDevice.isLargeOrExtraLargeDevice() {
            return PXLayout.getAvailabelScreenHeight(in: viewController, applyingMarginFactor: 46)
        } else {
            return PXLayout.getAvailabelScreenHeight(in: viewController, applyingMarginFactor: 40)
        }
    }

    static func getWhiteViewHeight(viewController: UIViewController) -> CGFloat {
        if UIDevice.isSmallDevice() {
            return PXLayout.getAvailabelScreenHeight(in: viewController, applyingMarginFactor: 62)
        } else if UIDevice.isLargeOrExtraLargeDevice() {
            return PXLayout.getAvailabelScreenHeight(in: viewController, applyingMarginFactor: 54)
        } else {
            return PXLayout.getAvailabelScreenHeight(in: viewController, applyingMarginFactor: 60)
        }
    }
    
    static func getCardTypeForContext(deviceSize: PXDeviceSize.Sizes, hasCharges: Bool, hasDiscounts: Bool, hasInstallments: Bool, hasSplit: Bool) -> MLCardDrawerType {
        
        switch deviceSize {
        case .small:
            if hasInstallments || hasSplit {
                // On small devices, if it has installments or split, return medium size card
                return .medium
            } else {
                // On small devices if there is no installments or split return large size card
                return .large
            }
        case .regular:
            // On regular devices, if it has installments, return medium size card
            if hasInstallments {
                return .medium
            } else {
                return .large
            }
        case .large, .extraLarge:
            // On large or extra-large devices always return large size card
            return .large
        default:
            return .large
        }
    }
}
