//
//  AndesCardBodyPadding.swift
//  AndesUI
//
//  Created by Federico Gabriel Nosmor on 19/11/2020.
//

import Foundation

/// Used to define the body padding of an AndesCard
@objc public enum AndesCardBodyPadding: Int, AndesEnumStringConvertible {
    case none
    case small
    case medium
    case large
    case xlarge

    public static func keyFor(_ value: AndesCardBodyPadding) -> String {
        switch value {
        case .none: return "NONE"
        case .small: return "SMALL"
        case .medium: return "MEDIUM"
        case .large: return "LARGE"
        case .xlarge: return "XLARGE"
        }
    }
}
