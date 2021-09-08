//
//  UILabel.swift
//  themovieapp
//
//  Created by adilcan on 8.09.2021.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLabelProperties(frame: CGRect, text: String, textColor: UIColor, font: String, fontSize: CGFloat, addOptionalsAction: (() -> Swift.Void)? = nil) {
        self.frame = frame
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: font, size: fontSize)
        addOptionalsAction?()
    }
}
