//
//  CustomTextField.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 22/10/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

//    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
//        //let originalRect = super.clearButtonRect(forBounds: bounds)
//
//        return CGRect(x: 300, y: 5, width: 40, height: 20)
//
//    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        
        return originalRect.offsetBy(dx: 3, dy: -68)
    }
}

