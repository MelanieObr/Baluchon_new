//
//  WeatherViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Property
    
    //instance of the WeatherService class
    private let weatherService = WeatherService()
    
    // MARK: - Outlets
    
    @IBOutlet private var destination: [UITextField]!
    @IBOutlet private var iconWeather: [UIImageView]!
    @IBOutlet private weak var weatherActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private var descriptionWeather: [UILabel]!
    @IBOutlet private weak var forecastButton: UIButton!
    @IBOutlet private var info: [UIStackView]!
    @IBOutlet private var temp: [UILabel]!
    @IBOutlet private var wind: [UILabel]!
    
    // MARK: - View life cycle, update weather for New-York and Strasbourg
    
    override func viewDidLoad() {
        updateWeather()
    }
    
    // MARK: - Action to tap on the button to show forecast
    
    @IBAction private func didTapeWeatherForecastButton(_ sender: Any) {
        updateWeather()
    }
    
    // MARK: - Methods
    
    // method to get data with the API
    private func updateWeather() {
        defaultSetting()
        for i in 0...1 {
            weatherService.getWeather(from: destination[i].text ?? "") { result in
                switch result {
                case.success(let weather):
                    self.displayScreen(data: weather, index: i)
                case .failure:
                    self.alert(title: "Erreur", message: "Une erreur est survenue vérifier la ville saisie et la connexion internet")
                }
            }
        }
        activityIndicator(activityIndicator: weatherActivityIndicator, button: forecastButton, showActivityIndicator: false)
    }
    
    // default settings
    private func defaultSetting() {
        if destination[0].text == "" {
            destination[0].text = "  New York"
        } else if destination[1].text == "" {
            destination[1].text = "  Strasbourg"
        }
    }
    
    // display informations
    private func displayScreen(data: WeatherInfo, index: Int) {
        info[index].isHidden = false
        temp[index].text = convertToString(value: data.main.temp) + "°C"
        wind[index].text = convertToString(value: data.wind.speed) + "km/h"
        descriptionWeather[index].text = data.weather[0].main
        descriptionWeather[index].isHidden = false
        iconWeather[index].isHidden = false
        iconWeather[index].image = WeatherView.icon[data.weather[0].main]
    }
}

// MARK: - Extension with action to dismiss keyboard

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        destination[0].resignFirstResponder()
        destination[1].resignFirstResponder()
    }
}
