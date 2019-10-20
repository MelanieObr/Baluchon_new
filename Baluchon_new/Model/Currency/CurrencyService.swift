//
//  CurrencyService.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

class CurrencyService {

    // MARK: - Properties
    
    private let keyCurrency = valueForAPIKey(named: "ApiCurrency")
    private var currencySession: URLSession
    private var task: URLSessionDataTask?
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    // MARK: - Methods
    
    func getRate(callback: @escaping (Bool, Double?) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(keyCurrency)&base=EUR&symbols=USD") else { return }
        task?.cancel()
        task = currencySession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Currrency.self, from: data),
                    // convert a mettre
                    let usdRate = responseJSON.rates["USD"] else {
                        callback(false, nil)
                        return
                }
                callback(true, usdRate)
            }
        }
        task?.resume()
    }
    
}
