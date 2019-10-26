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
    func getRate(callback: @escaping (Result<Currrency, ErrorCases>) -> Void) {
        guard let apiKey = ApiMethod().apiKey else { return }
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey.apiCurrency)&base=EUR&symbols=USD") else { return }
        task?.cancel()
        task = currencySession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(.errorNetwork))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.invalidRequest))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Currrency.self, from: data) else {
                    // convert à mettre... pas réussi
                    callback(.failure(.errorData))
                    return
                }
                callback(.success(responseJSON))
                
            }
        }
        task?.resume()
    }
    
}
