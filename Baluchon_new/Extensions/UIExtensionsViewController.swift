//
//  UIExtensionsViewController.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

extension UIViewController {
        
        // Create an observer for each notification
        func createObserver() {
            let firstNotif = Notification.Name(rawValue: "Erreur réseau!")
            NotificationCenter.default.addObserver(self, selector: #selector(networkError), name: firstNotif, object: nil)
            
            let secondNotif = Notification.Name(rawValue: "Réponse serveur incorrect!")
            NotificationCenter.default.addObserver(self, selector: #selector(incorrectServerResponse), name: secondNotif, object: nil)
            
            let thirdNotif = Notification.Name(rawValue: "Data illisible!")
            NotificationCenter.default.addObserver(self, selector: #selector(dataUnreadable), name: thirdNotif, object: nil)
        }
        
        // Show a custom alert based on title and message received
        func alert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
        // Display a network alert
        @objc func networkError() {
            alert(title: "Erreur réseau!", message: "Vérifier votre connexion!")
        }
        
        // Display an alert in case of incorrect response from the server
        @objc func incorrectServerResponse() {
            alert(title: "Réponse serveur incorrect!", message: "Le serveur a renvoyé une erreur!")
        }
        
        // Displays an alert if the received data is not interpretable
        @objc func dataUnreadable() {
            alert(title: "Data illisible!", message: "Les donner reçu n'est pas utilisable!")
        }
        
        // Convert the received parameter to a string
        func convertToString(value: Float) -> String {
            return String(value)
        }
        
        // Display the received UIButton and hide the UIActivityIndicatorView
        func displayButton(button: UIButton, activityIndicator: UIActivityIndicatorView) {
            button.isHidden =  false
            activityIndicator.isHidden = true
            
        }
        
        // Display the UIActivityIndicatorView and hide the UIButton received
        func hideButton(button: UIButton, activityIndicator: UIActivityIndicatorView) {
            button.isHidden =  true
            activityIndicator.isHidden = false
        }
        
        // Applies the text received to a UITextView
        func refreshScreen(text: String, textView: UITextView) {
            textView.text = text
        }
}
