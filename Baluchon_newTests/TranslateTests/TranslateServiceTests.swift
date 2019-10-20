//
//  TranslateServiceTests.swift
//  Baluchon_newTests
//
//  Created by Mélanie Obringer on 01/10/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import XCTest
@testable import Baluchon_new

class TranslateServiceTests: XCTestCase {
    
    // test callback return error
    func testTranslateShouldPostFailedCallbackIfError() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback doesn't return data
    func testTranslateShouldPostFailedCallbackIfNoData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .en, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback return incorrect response
    func testTranslateShouldPostFailedCallbackIncorrectResponse() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .detect, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback return incorrect data
    func testTranslateShouldPostFailedCallbackIncorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback success with no error and correct data source french
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let fakeTranslation: String = "Hello"
        
        translate.translate(language: .fr, text: "Bonjour") { (success, translatedText) in
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            XCTAssertEqual(fakeTranslation, translatedText!)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback success with no error and correct data source english
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectDataSourceEnglish() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectDataEnglish, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let fakeTranslation: String = "salut"
        
        translate.translate(language: .en, text: "Hello") { (success, translatedText) in
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            XCTAssertEqual(fakeTranslation, translatedText!)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // test callback success with no error and correct data source english
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectDataSourceDetect() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectDataDetect, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let fakeTranslation: String = "merci"
        
        translate.translate(language: .detect, text: "gracias") { (success, translatedText) in
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            XCTAssertEqual(fakeTranslation, translatedText!)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
