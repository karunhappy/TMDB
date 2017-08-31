//
//  Common.swift
//  TestTask
//
//  Created by Karun Aggarwal on 31/08/17.
//  Copyright © 2017 Squareloops. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class Common: NSObject {
    
/// Singleton Object
    class var share: Common {
        struct Static {
            static let instance: Common = Common()
        }
        return Static.instance
    }
    
/// Common Variables
    let screenSize = UIScreen.main.bounds
    let appName = "Test Task"
    
/// Activity Indicator
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
/// Load Images
    func loadImage(img: UIImageView, url: URL) {
        img.kf.setImage(with: url)
    }
    
/// Loader - Start Activity Indicator
    func showActivityIndicator(_ uiView: UIView) {
        self.container.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        self.container.backgroundColor = UIColor(red: 18/255, green: 6/255, blue: 0/255, alpha: 0.3)
        
        self.loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        uiView.bringSubview(toFront: container)
        activityIndicator.startAnimating()
    }

/// Loader - Stop Activity Indicator
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
/// Alert Message
    func alertMessage(_ msg: String, action: Bool = true) -> UIAlertController {
        let alert = UIAlertController(title: self.appName, message: msg, preferredStyle: .alert)
        if action {
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
        }
        return alert
    }
    
}
