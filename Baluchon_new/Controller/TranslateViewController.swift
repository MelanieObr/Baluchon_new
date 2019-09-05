//
//  TranslateViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var translation: UITextView!
    @IBOutlet weak var UIPicker: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sourceLanguage: UILabel!
    @IBOutlet weak var languageTranslation: UILabel!
    
    private var translate = TranslateService() // Stock the instance of the TranslateService class
    private var index: Int = 0 // Stock index of UIPickerView
    
    override func viewDidLoad() {
        createObserver()
    }
    
    // Removes the keyboard and stores the text entered in the text variable
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text.resignFirstResponder()
    }
    
    // Manages the data received by the API
    @IBAction func didTapeTranslateButton(_ sender: Any) {
        index = UIPicker.selectedRow(inComponent: 0)
        
        guard text.text != "" else {
            alert(title: "ERREUR", message: "Aucun texte saisi")
            return
        }
        
        hideButton(button: translateButton, activityIndicator: translateActivityIndicator)
        translate.translate(Index: index, text: text.text) { (success, translatedText) in
            if success == true {
                self.refreshScreen(text: translatedText!, textView: self.translation)
            } else {
                self.alert(title: "Erreur", message: "Erreur reseau")
            }
        }
        displayButton(button: translateButton, activityIndicator: translateActivityIndicator)
    }
    
    // Modify the interface text to match the UIPickerView
    private func changeLanguage(index: Int) {
        switch index {
        case 0:
            sourceLanguage.text = "Français"
            languageTranslation.text = "Anglais"
        case 1:
            sourceLanguage.text = "Anglais"
            languageTranslation.text = "Français"
        case 2:
            sourceLanguage.text = "Detectable"
            languageTranslation.text = "Français"
        default:
            break
        }
    }
    
}

extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Returns the column number of the UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns the number of lines in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count
    }
    
    // Returns the value corresponding to the request line of UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        changeLanguage(index: row)
        return language[row]
    }
}

