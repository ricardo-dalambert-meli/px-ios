//
//  AndesProgressIndicatorSizeXSmall.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 10-12-20.
//

import Foundation

internal struct AndesProgressIndicatorSizeXSmall: AndesProgressIndicatorSizeProtocol {
    var textSpacing: CGFloat = 12
    var strokeWidth: CGFloat = 2
    var height: CGFloat = 16
    var horizontalDistribution: Bool = true

    var textFont: UIFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)

}
