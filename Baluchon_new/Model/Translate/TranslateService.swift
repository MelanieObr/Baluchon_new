//
//  TranslateService.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation


enum Language {
    case fr
    case en
    case detect
}

class TranslateService {
    
    //  MARK: - Properties
    
    let language: [String] = ["Français > Anglais", "Anglais > Français", "Detection > Français"]
    // source message language
    private var source: String = "fr"
    // target message language
    private var target: String = "en"
    // API Key
    private var keyTranslate = valueForAPIKey(named: "ApiTranslate")
    // URLSession
    private var translateSession: URLSession
    // URLSessionsDataTask
    var task: URLSessionDataTask?
    // Init URLSession
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // MARK: - Methods
    
    // send a request to the Google Translate API and return response
    func translate(language: Language, text: String, callback: @escaping (Bool, String?) -> Void) {
        
        guard let request = createTranslateRequest(text: text, language: language) else { return }
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data),
                    let textTranslated = responseJSON.data.translations[0].translatedText else {
                        callback(false, nil)
                        return
                }
                callback(true, textTranslated)
            }
        }
        task?.resume()
    }
    
    // create a request based on the received parameter
    private func createTranslateRequest(text: String, language: Language) -> URLRequest? {
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let q: String = text
        selectedLanguage(language: language)
        
        let body = "q=\(q)" + "&\(source)" + "&target=\(target)" + "&key=\(keyTranslate)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    
    
    // change source and target by the index
    func selectedLanguage(language: Language) {
        switch language {
        case .fr :
            source = "source=fr"
            target = "en"
        case .en :
            source = "source=en"
            target = "fr"
        case .detect :
            source = "detect"
            target = "fr"
        }
    }
}
