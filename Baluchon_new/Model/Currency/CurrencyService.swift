//
//  CurrencyService.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

final class CurrencyService {
    
    // MARK: - Properties
    
    // URLSessionsDataTask
    private var task: URLSessionDataTask?
    // URLSession
    private var currencySession: URLSession
    // initialiaze URLSession
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    // MARK: - Method
    
    /// send a request to Fixer API and return response
    func getRate(callback: @escaping (Result<Currency, ErrorCases>) -> Void) {
        // stock API key
        guard let apiKey = ApiKeyExtractor().apiKey else { return }
        // compose url
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey.apiCurrency)&base=EUR&symbols=USD") else { return }
        task?.cancel()
        task = currencySession.dataTask(with: url) { (data, response, error) in
            // check error
            guard let data = data, error == nil else {
                callback(.failure(.errorNetwork))
                return
            }
            // check status response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidRequest))
                return
            }
            // check response JSON
            guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                callback(.failure(.errorDecode))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
