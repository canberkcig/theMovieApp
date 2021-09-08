//
//  UITextView.swift
//  themovieapp
//
//  Created by adilcan on 8.09.2021.
//

import Foundation
import UIKit

extension UITextView {
    
    func setTextViewProperties(frame: CGRect, text: String, textColor: UIColor, backgroundColor: UIColor, font: String, fontSize: CGFloat, isUserInteractionEnabled: Bool = false, isEditable: Bool = false, addOptionalsAction: (() -> Swift.Void)? = nil) {
        self.frame = frame
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: font, size: fontSize)
        self.backgroundColor = backgroundColor
        self.isEditable = isEditable
        self.isUserInteractionEnabled = isUserInteractionEnabled
        addOptionalsAction?()
    }
}
