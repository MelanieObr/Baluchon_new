//
//  TranslateViewController.swift
//  Baluchon_new

//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Properties
    
    // instance of the TranslateService class
    private let translateService = TranslateService()
    // instance of index
    private var index: Int = 0
    // instance of type language
    private var language: Language = .fr
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var translation: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sourceLanguage: UILabel!
    @IBOutlet weak var languageTranslation: UILabel!
    
    // MARK: - view life cycle : hide the activity indicator
    
    override func viewDidLoad() {
        text.textAlignment = .natural
        activityIndicator(activityIndicator: translateActivityIndicator, button: translateButton, showActivityIndicator: false)
    }
    
    // MARK: - Actions
    
    // action to manages the data received by the API, show activity indicator and hide button
    @IBAction func didTapeTranslateButton(_ sender: Any) {
        index = pickerView.selectedRow(inComponent: 0)
        guard text.text != "" else {
            alert(title: "Erreur", message: "Aucun texte saisi !")
            return
        }
        
        activityIndicator(activityIndicator: translateActivityIndicator, button: translateButton, showActivityIndicator: true)
        translateService.translate(language: language, text: text.text ?? "") { result in
            switch result {
            case .success(let translatedText):
                self.refreshScreen(data: translatedText, textView: self.translation)
            case .failure:
                self.alert(title: "Erreur", message: "Une erreur est survenue, vérifier la votre saisie et la connexion internet !")
            }
            self.activityIndicator(activityIndicator: self.translateActivityIndicator, button: self.translateButton, showActivityIndicator: false)
        }
    }
    
    
    // MARK: - Methods
    
    // method to change the label language to match with the pickerView selected
    private func changeLanguage(index: Int) {
        switch index {
        case 0:
            sourceLanguage.text = "Français"
            languageTranslation.text = "Anglais"
            language = .fr
        case 1:
            sourceLanguage.text = "Anglais"
            languageTranslation.text = "Français"
            language = .en
        case 2:
            sourceLanguage.text = "Detection"
            languageTranslation.text = "Français"
            language = .detect
        default:
            break
        }
    }
    
    // Method to display result of translation in the textView
    func refreshScreen(data: Translate, textView: UITextView) {
        textView.text = data.data.translations[0].translatedText
    }
}

extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Extension for pickerView
    
    // method to return the number's colum of the UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // method to return the number of lines in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return translateService.language.count
    }
    
    // method to returns the value corresponding to the pickerView, change color text in white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        changeLanguage(index: row)
        return NSAttributedString(string: translateService.language[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

extension TranslateViewController: UITextFieldDelegate {
    
    // MARK: - Extension to dismiss Keyboard
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text.resignFirstResponder()
    }
}


