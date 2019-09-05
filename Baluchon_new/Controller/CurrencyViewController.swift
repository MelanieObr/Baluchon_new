//
//  CurrencyViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    var fromSymbol = "EUR"
    var toSymbol = "USD"
    
    //MARK: Outlets
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var currencyResultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    // Actions
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        convert()
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        
        currencyTextField.resignFirstResponder()
    }
    
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        ActivityIndicator.activityIndicator(activityIndicator: activityIndicator, button: convertButton, showActivityIndicator: false)
        CurrencyService.shared.getCurrency {(currency) in }
    }
    
    //MARK: Methods
    
    
    // Get API data from Model
    func convert() {
        CurrencyService.shared.getCurrency {(currency) in
            if let c = currency, let text = self.currencyTextField.text, let value = Double(text) {
                let result = c.convert(value: value, from: self.fromSymbol, to: self.toSymbol)
                self.currencyResultLabel.text = String(result)
            }
            
            
        }
    }
    private func clear() {
        currencyTextField.text = ""
        currencyResultLabel.text = ""
    }
}
