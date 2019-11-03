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
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback doesn't return data
    func testTranslateShouldPostFailedCallbackIfNoData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback return incorrect response
    func testTranslateShouldPostFailedCallbackIncorrectResponse() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback return incorrect data
    func testTranslateShouldPostFailedCallbackIncorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback success with no error and correct data source french
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .success(let resultTranslate) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(resultTranslate.data.translations[0].translatedText, "Hello")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback success with no error and correct data source english
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectDataSourceEnglish() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectDataEnglish, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .en, text: "Hello") { result in
            guard case .success(let resultTranslate) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(resultTranslate.data.translations[0].translatedText, "Salut")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback success with no error and correct data source english
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectDataSourceDetect() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectDataDetect, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.translate(language: .detect, text: "Gracias") { result in
            guard case .success(let result) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(result.data.translations[0].translatedText, "Merci")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
