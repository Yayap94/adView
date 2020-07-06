//
//  CurrencyFormatter.swift
//  AdView
//
//  Created by Nicolas SABELLA on 06/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation

class CurrencyFormatter {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    static func getFrenchCurrencyPrice(for value: Int) -> String {
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
