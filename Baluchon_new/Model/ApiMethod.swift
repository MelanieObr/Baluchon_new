//
//  ApiMethod.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

final class ApiMethod {
    // get API Keys from ApiKeys.plist (git ignored)
    var apiKey: ApiKeys? {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else { return nil }
        guard let dataApi = try? PropertyListDecoder().decode(ApiKeys.self, from: data) else { return nil }
        return dataApi
    }
}

// structure with name of keys in ApiKeys plist file
struct ApiKeys: Decodable {
    let apiCurrency: String
    let apiTranslate: String
    let apiWeather: String
}
