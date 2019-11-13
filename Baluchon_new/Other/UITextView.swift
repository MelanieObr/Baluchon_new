//
//  UITextView.swift
//  Baluchon_new
//
//  Created by Mélanie Obringer on 11/11/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import UIKit

// MARK: - Extension to align in center the textView

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
