//
//  AlertShowable.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 30/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

protocol AlertShowable {
    func showAlert(title : String?, message : String?)
    func showAlert(title : String?, message : String?, actions : [UIAlertAction]?, handler : ((UIAlertAction) -> Void)?)
    func showError(message : String)
}

extension AlertShowable where Self : UIViewController {
    func showAlert(title : String?, message : String?){
        let okAction = UIAlertAction (title: "Ok", style: .default, handler: nil)
        showAlert(title: title, message: message, actions: [okAction])
    }
    
    func showAlert(title : String?, message : String?, actions : [UIAlertAction]?, handler : ((UIAlertAction) -> Void)? = nil){
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        
        if let actions = actions{
            actions.forEach {
                action in
                alertController.addAction(action)
            }
        }
        else{
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
            alertController.addAction(okAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showError(message : String){
        showAlert(title: "Error", message: message)
    }
}
