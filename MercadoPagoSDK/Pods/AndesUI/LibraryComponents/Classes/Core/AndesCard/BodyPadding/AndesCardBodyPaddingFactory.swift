//
//  AndesCardBodyPaddingFactory.swift
//  AndesUI
//
//  Created by Federico Gabriel Nosmor on 19/11/2020.
//

import Foundation

internal class AndesCardBodyPaddingFactory {
    static func provide(_ padding: AndesCardBodyPadding) -> AndesCardBodyPaddingProtocol {
        switch padding {
        case .none:
            return AndesCardBodyPaddingNone()
        case .small:
            return AndesCardBodyPaddingSmall()
        case .medium:
            return AndesCardBodyPaddingMedium()
        case .large:
            return AndesCardBodyPaddingLarge()
        case .xlarge:
            return AndesCardBodyPaddingXLarge()
        }
    }
}
