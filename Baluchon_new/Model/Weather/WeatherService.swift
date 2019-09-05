//
//  WeatherService.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

class WeatherService {
    private var weatherSession = URLSession(configuration: .default) // Stock a URLSessions
    private var task: URLSessionDataTask?  // Stock a URLSessionsDataTask
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // Send a request to the OpenWeatherMap API and return this response
    func getWeather(city: String, callback: @escaping (Bool, WeatherInfo?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&APPID=e31016211bf94717939987cc27356c7d&units=metric")!
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    self.notification(message: "Erreur réseau!")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    self.notification(message: "Réponse serveur incorrect!")
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                    callback(false, nil)
                    self.notification(message: "Data illisible!")
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    // Send a notification
    private func notification(message: String) {
        let name = Notification.Name(message)
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
}



