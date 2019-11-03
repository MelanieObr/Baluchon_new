//
//  CurrencyViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

final class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    // instance of the symbols
    private let fromSymbol = "EUR"
    private let toSymbol = "USD"
    // instance of the CurrencyService class
    private let currencyService = CurrencyService()
    
    // MARK: - Outlets
    
    @IBOutlet private weak var currencyTextField: UITextField!
    @IBOutlet private weak var currencyResultLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var convertButton: UIButton!
    
    // MARK: - Action to check if there's value to convert
    
    @IBAction private func tappedConvertButton(_ sender: UIButton) {
        guard currencyTextField.text != "", currencyTextField.text != "," else {
            // send an alert to enter a value to convert
            alert(title: "Erreur", message: "Entrez un montant !")
            return
        }
        self.convertCurrency()
    }
    
    // MARK: - View Life cycle : hide activityIndicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: false)
    }
    
    // MARK: - Methods
    
    /// method to convert
    private func convertCurrency() {
        
        // change type of the value in Double for the call
        guard let text = currencyTextField.text, let value = Double(text) else { return }
        
        // show activityIndicator when we send the request to the API
        activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: true)
        
        // call API to send request
        currencyService.getRate { result in
            
            // hide activityIndicator when we get the result
            self.activityIndicator(activityIndicator: self.activityIndicator, button: self.convertButton, showActivityIndicator: false)
            
            // manage the result success or failure
            switch result {
                
            // display the value converted
            case .success(let currency):
                self.displayWithTwoDecimals(result: currency.convert(value: value, from: self.fromSymbol, to: self.toSymbol))
                
            // send an alert that the exchange doesn't work
            case .failure:
                self.alert(title: "Erreur", message: "Impossible de convertir, vérifier la votre saisie et la connexion internet !")
            }
        }
    }
    
    /// method to display result with two decimals
    func displayWithTwoDecimals(result: Double){
        let result = String(format: "%.2f", result)
        currencyResultLabel.text = result
    }
}

// MARK: - Extension to dismiss keyboard

extension CurrencyViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }
}
