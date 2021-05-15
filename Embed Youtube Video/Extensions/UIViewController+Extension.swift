//
//  UIViewController+Extension.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import Foundation
import UIKit


extension UIViewController{
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
