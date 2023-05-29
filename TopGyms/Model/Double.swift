//
//  Double.swift
//  TopGyms
//
//  Created by Denis on 5/24/23.
//

import Foundation

extension Double {
    ///converts double into 2 decimal places
    ///```
    ///Convert 1234.56 to $1,234,56
    ///Convert 12.3456 to $12,3456
    ///Convert 0.123456 to $0,23456
    ///```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
    ///converts double into String  2 digits
    ///```
    ///Convert 1234.56 to "$1,234,56"
    ///Convert 12.3456 to "$12,3456"
    ///Convert 0.123456 to "$0,23456"
    ///```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from:number) ?? "0.00"
    }
}
