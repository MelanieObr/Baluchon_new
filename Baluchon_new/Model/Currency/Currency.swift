//
//  Currency.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

// structure to manage data and to convert

struct Currency: Decodable {
    
    var rates: [String: Double]
    
    private func convertFromEuro(value: Double, rate: Double) -> Double {
        return value * rate
    }
    
    func convert(value: Double, from: String, to: String) -> Double {
        guard let rate = rates[to] else { return 0.00 }
        let convertValue = convertFromEuro(value: value, rate: rate)
        return convertValue
    }
}

