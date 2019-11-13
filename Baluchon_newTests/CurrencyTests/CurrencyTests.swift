//
//  CurrencyTests.swift
//  Baluchon_newTests
//
//  Created by Mélanie Obringer on 04/11/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import XCTest
@testable import Baluchon_new

class CurrencyTests: XCTestCase {
    
    let currency = Currency(rates: ["USD": 1.092908])
    
    // test if currency return a correct result
    func testCurrencyConvertShouldReturnCorrectResult() {
        let result = currency.convert(value: 1, from: "EUR", to: "USD")
        XCTAssertEqual(result, 1.092908)
    }
    
}
