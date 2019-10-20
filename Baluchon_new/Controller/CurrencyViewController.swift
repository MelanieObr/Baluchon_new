//
//  CurrencyViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    let fromSymbol = "EUR"
    let toSymbol = "USD"
    private let currencyService = CurrencyService()
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var currencyResultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    
    // MARK: - Action and alert to enter value
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        guard currencyTextField.text != "", currencyTextField.text != "," else {
            alert(title: "Erreur", message: "Entrez un montant !")
            return
        }
        self.convertCurrency()
    }
    
    // MARK: - View Life cycle
    // notifications and hide activity indicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: false)
    }
    
    // MARK: - Methods
    
    fileprivate func convertCurrency() {
        activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: true)
        
        // Recover the amount to convert in the textField
        let baseAmount = getAmount(textfield: currencyTextField)
        
        currencyService.getRate { (success, usdRate) in
            self.activityIndicator(activityIndicator: self.activityIndicator, button: self.convertButton, showActivityIndicator: false)
            
            
            if success, let usdRate = usdRate {
                let convertedAmount = baseAmount * usdRate
                // Convert the amount in string with two decimal numbers
                let stringAmount = String(format: "%.2f", convertedAmount)
                self.currencyResultLabel.text = stringAmount
            } else {
                // Display an error
                self.alert(title: "Erreur", message: "Impossible de convertir")
            }
        }
    }
    
    func getAmount(textfield: UITextField) -> Double {
        guard let stringAmount = textfield.text else { return 0.0 }
        guard let amount = Double(stringAmount) else { return 0.0 }
        return amount
    }
}

// MARK: - Extension dismiss keyboard

extension CurrencyViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }
}
