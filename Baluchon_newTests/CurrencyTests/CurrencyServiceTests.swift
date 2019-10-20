//
//  CurrencyServiceTests.swift
//  Baluchon_newTests
//
//  Created by Mélanie Obringer on 01/10/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import XCTest
@testable import Baluchon_new

class CurrencyServiceTests: XCTestCase {
    
    
    // Test if there is an error
    func testGetRateShouldPostFailedCallbackIfError() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is no data
    func testGetRateShouldPostFailedCallbackIfNoData() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there an incorrect response
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is incorrect data
    func testGetRateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
//    // Test if there is response and data correct and no error
//    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        // Given
//        let currencyService = CurrencyService(currencySession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil))
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        currencyService.getRate { (success, rate) in
//            // Then
//            XCTAssertTrue(success)
//            XCTAssertNotNil(rate)
//
//            let rates: [String: Float] = ["USD": 1.092908]
//            XCTAssertEqual(rates["USD"], rates)
//
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
}
