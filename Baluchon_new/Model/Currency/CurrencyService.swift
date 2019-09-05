//
//  CurrencyService.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

class CurrencyService {
    static var shared = CurrencyService()
    
    private init() {}
    
    private var currency: Currrency?
    //private var 
    private static let currencyUrl = URL(string: "http://data.fixer.io/api/latest?access_key=a17282a783859891f1f44f7d80586ab7")!
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    
    init(session:URLSession) {
        self.session = session
        
        
    }
    
    /// Getting Data
    func getCurrency(callback: @escaping (Currrency?) -> Void) {
        if let c = currency {
            callback(c)
            return
            
        }
        task?.cancel()
        task = session.dataTask(with: CurrencyService.currencyUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(nil)
                    return
                    
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else  {
                    callback(nil)
                    return
                    
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Currrency.self, from: data) else {
                    callback(nil)
                    return
                }
                
                self.currency = responseJSON
                callback(responseJSON)
            }
        }
        
        task?.resume()
    }
}
