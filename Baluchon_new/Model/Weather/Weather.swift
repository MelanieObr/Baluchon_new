//
//  Weather.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

// Structures to manage the data

struct WeatherInfo: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Decodable {
    let main: String
}

struct Main: Decodable {
    let temp: Float
}

struct Wind: Decodable {
    let speed: Float
}
