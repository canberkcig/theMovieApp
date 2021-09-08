//
//  UIView.swift
//  themovieapp
//
//  Created by adilcan on 8.09.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func setCornerRadius(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
