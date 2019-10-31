//
//  FakeResponseData.swift
//  Baluchon_newTests
//
//  Created by Mélanie Obringer on 01/10/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var translateCorrectDataEnglish: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslateEnglish", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var translateCorrectDataDetect: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslateDetect", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let IncorrectData = "erreur".data(using: .utf8)
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class testError: Error {}
    static let error = testError()
}
