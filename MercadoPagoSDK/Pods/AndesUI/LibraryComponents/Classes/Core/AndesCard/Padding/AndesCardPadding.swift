//
//  AndesCardPadding.swift
//  AndesUI
//
//  Created by Martin Victory on 13/07/2020.
//

import Foundation

/// Used to define the padding of an AndesCard
@objc public enum AndesCardPadding: Int, AndesEnumStringConvertible {
    case none
    case small
    case medium
    case large
    case xlarge

    public static func keyFor(_ value: AndesCardPadding) -> String {
        switch value {
        case .none: return "NONE"
        case .small: return "SMALL"
        case .medium: return "MEDIUM"
        case .large: return "LARGE"
        case .xlarge: return "XLARGE"
        }
    }

    public func toAndesCardBodyPadding() -> AndesCardBodyPadding {
        switch self {
        case .none: return .none
        case .small: return .small
        case .medium: return .medium
        case .large: return .large
        case .xlarge: return .xlarge
        }
    }
}
