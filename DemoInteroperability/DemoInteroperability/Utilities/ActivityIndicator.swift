//
//  ActivityIndicator.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 30/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

// Ideally, ActivityIndicator should be of type Struct, but ActivityIndicator is used in Objective C module as well (to enhance code reusability & to avoid code duplicacy). Hence, it is made of type Class.

//struct ActivityIndicator {
@objc class ActivityIndicator : NSObject {

    var container: UIView = UIView()
    var loadingView = UIView()
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var label: UILabel = UILabel()
    
    @objc static let shared = ActivityIndicator()
    
    private override init() {}
    
    @objc func showAcitivityIndicator(view: UIView, message: String) {
        
        let screen = Device.bounds()
        container.frame = screen
        container.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        container.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = CGPoint(x: loadingView.frame.width / 2, y: loadingView.frame.height / 2)
        indicator.style = .whiteLarge
        indicator.hidesWhenStopped = true
        
        label.text = message
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.sizeToFit()
        
        loadingView.addSubview(label)
        loadingView.addSubview(indicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 2).isActive = true
        
        indicator.startAnimating()
    }
    
    @objc func hideActivityIndicator(view _: UIView) {
        indicator.stopAnimating()
        label.text = ""
        loadingView.removeFromSuperview()
        container.removeFromSuperview()
    }
}
