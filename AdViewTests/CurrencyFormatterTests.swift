//
//  CurrencyFormatterTests.swift
//  AdViewTests
//
//  Created by Nicolas SABELLA on 07/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import XCTest
@testable import AdView

class CurrencyFormatterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFrenchCurrency() throws {
        let price = 150
        XCTAssertEqual(CurrencyFormatter.getFrenchCurrencyPrice(for: price), "150,00 €")
    }

}
