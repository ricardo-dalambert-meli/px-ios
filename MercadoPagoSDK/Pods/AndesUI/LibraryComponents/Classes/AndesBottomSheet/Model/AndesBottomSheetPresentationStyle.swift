//
//  AndesBottomSheetPresentationSize.swift
//  AndesUI
//
//  Created by INAKI YABAR BILBAO on 29/12/2020.
//

import Foundation

/// Used to define the way the bottom sheet will be presented
@objc public enum AndesBottomSheetPresentationStyle: Int, AndesEnumStringConvertible {
    case fixed /// default style, maximum initial height is 60% of the screen
    case intrinsic /// initial height can excede 60% of the screen, depending on the intrinsic content size of the contained controller

    public static func keyFor(_ value: AndesBottomSheetPresentationStyle) -> String {
        switch value {
            case .fixed: return "fixed"
            case .intrinsic: return "intrinsic"
        }
    }
}
