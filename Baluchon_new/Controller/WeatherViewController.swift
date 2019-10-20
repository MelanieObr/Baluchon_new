//
//  WeatherViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Property
    
    //instance of the WeatherService class
    private let weather = WeatherService()
    
    // MARK: - Outlets
    
    @IBOutlet var destination: [UITextField]!
    @IBOutlet var iconWeather: [UIImageView]!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var descriptionWeather: [UILabel]!
    @IBOutlet var forecastButton: UIButton!
    @IBOutlet var info: [UIStackView]!
    @IBOutlet var temp: [UILabel]!
    @IBOutlet var wind: [UILabel]!
    
    // MARK: - View life cycle, update weather for New-York and Strasbourg
    
    override func viewDidLoad() {
        updateWeather()
    }
    
    // MARK: - Action to tap on the button to show forecast
    
    @IBAction func didTapeWeatherForecastButton(_ sender: Any) {
        updateWeather()
    }
    
    // MARK: - Methods
    
    // method to get data with the API
    func updateWeather() {
        defaultSetting()
        for i in 0...1 {
            weather.getWeather(city: destination[i].text!) { (success, weather) in
                if success {
                    self.displayScreen(weather: weather!, index: i)
                } else {
                    self.alert(title: "Erreur", message: "Une erreur est survenue vérifier la Ville saisie et la connexion internet")
                }
            }
        }
        activityIndicator(activityIndicator: weatherActivityIndicator, button: forecastButton, showActivityIndicator: false)
    }
    
    // default settings
    private func defaultSetting() {
        if destination[0].text == "" {
            destination[0].text = "New York"
        }else if destination[1].text == "" {
            destination[1].text = "Strasbourg"
        }
    }
    
    // display informations
    private func displayScreen(weather: WeatherInfo, index: Int) {
        info[index].isHidden = false
        temp[index].text = convertToString(value: weather.main.temp) + "°C"
        wind[index].text = convertToString(value: weather.wind.speed) + "km/h"
        descriptionWeather[index].text = weather.weather[0].main
        descriptionWeather[index].isHidden = false
        iconWeather[index].isHidden = false
        iconWeather[index].image = WeatherView.icon[weather.weather[0].main]
    }
}

// MARK: - Extension with action to dismiss keyboard

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        destination[0].resignFirstResponder()
        destination[1].resignFirstResponder()
    }
    
}