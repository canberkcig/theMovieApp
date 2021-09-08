//
//  BaseViewController.swift
//  themovieapp
//
//  Created by adilcan on 8.09.2021.
//

import Foundation
import UIKit
import PopupDialog
import MBProgressHUD

class BaseViewController: UIViewController {
    
    var shouldHideSubviewsOnRequestStatusChange = true

    enum RequestStatus {
        case unknown, pending, completed
    }
    
    
    var requestStatus: RequestStatus = .unknown {
        didSet {
            switch requestStatus {
            case .unknown:
                subviewsIsHidden = true
            case .pending:
                subviewsIsHidden = true
                MBProgressHUD.showAdded(to: view, animated: true)
            case .completed:
                subviewsIsHidden = false
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
    
    var subviewsIsHidden = false {
        didSet {
            if shouldHideSubviewsOnRequestStatusChange == true {
                DispatchQueue.main.async {
                    for subview in self.view.subviews {
                        subview.isHidden = self.subviewsIsHidden
                    }
                }
            }
        }
    }
    
    func showErrorDialog() {
        
        // Prepare the popup
        let title = "Error"
        let message = "Sorry, we couldn't load this page, possibly due to a connection problem. Please try again."
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: true) {
            print("Completed")
        }
        
        // Create second button
        let buttonOne = CancelButton(title: "OK") {
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne])
        
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
}


