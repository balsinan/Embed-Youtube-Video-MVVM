//
//  UIViewController+Extension.swift
//  Embed Youtube Video
//
//  Created by Sinan on 15.05.2021.
//

import Foundation
import UIKit
import XCDYouTubeKit

extension UIViewController{
    
    public func openVideo(id: String){
        
    XCDYouTubeClient.default().getVideoWithIdentifier(id) { (video, error) in
        
        guard error == nil else {
                return
        }
        if let video = video{
            AVPlayerViewControllerManager.shared.lowQualityMode = false
            AVPlayerViewControllerManager.shared.video = video
                
            self.present(AVPlayerViewControllerManager.shared.controller, animated: true) {
                        AVPlayerViewControllerManager.shared.controller.player?.play()
                }
            }
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
