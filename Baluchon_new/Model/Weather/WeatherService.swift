//
//  WeatherService.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

class WeatherService {
    
    // MARK: - Properties
    
    // API key
    let keyWeather = valueForAPIKey(named: "ApiWeather")
    // URLSessionDataTask
    private var task: URLSessionDataTask?
    // URLSession and initialisation
    private var weatherSession = URLSession(configuration: .default)
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - Methods
    
    // send a request to the OpenWeatherMap API and return this response
    func getWeather(city: String, callback: @escaping (Bool, WeatherInfo?) -> Void) {
        // stock city demanded by user and add it to the URL
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&APPID=\(keyWeather)&units=metric") else { return }
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}



