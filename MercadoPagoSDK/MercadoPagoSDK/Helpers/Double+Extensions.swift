//
//  Double+Extensions.swift
//  AndesUI
//
//  Created by Matheus Leandro Martins on 20/04/21.
//

import Foundation

public extension Double {
    func toCurrencyWithTwoDecimal() -> Double {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.maximumFractionDigits = 2
        let stringValue = currencyFormatter.string(from: NSNumber(value: self)) ?? ""
        
        return currencyFormatter.number(from: stringValue)?.doubleValue ?? 0
    }
}
