//
//  Translate.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 05/09/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import Foundation

// Struture to manage data

struct Translate: Decodable {
    var data: TranslationData
}

struct TranslationData: Decodable {
    var translations: [TranslationText]
}

struct TranslationText: Decodable {
    var translatedText: String
}


