//
//  PXDeviceSize.swift
//  MercadoPagoSDK
//
//  Created by Jonathan Scaramal on 13/05/2021.
//

import UIKit

public class PXDeviceSize {
    
    // Breakpoints took from https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/
    
    static let BREAKPOINT_SMALL : CGFloat = 568
    static let BREAKPOINT_REGULAR : CGFloat = 736
    static let BREAKPOINT_LARGE : CGFloat = 812
    static let BREAKPOINT_EXTRALARGE : CGFloat = 926
    
    enum Sizes {
        case small
        case regular
        case large
        case extraLarge
    }
    
    static func getDeviceSize(deviceHeight: CGFloat) -> Sizes {
        if deviceHeight <= BREAKPOINT_SMALL {
            return .small
        } else if deviceHeight <= BREAKPOINT_REGULAR {
            return .regular
        } else if deviceHeight <= BREAKPOINT_LARGE {
            return .large
        } else {
            return .extraLarge
        }
    }
}
