//
//  Translate.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

// The structure of this file makes it possible to store the Google Translate API data
struct Translate: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String?
}

let language: [String] = ["Français > Anglais", "Anglais > Français", "Detection > Français"] // Stock the different value of UIPickerView
