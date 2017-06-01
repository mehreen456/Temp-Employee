//
//  UIViewController.swift
//  Temp Provide
//
//  Created by kashif Saeed on 17/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import UIKit

typealias textFieldConfigurationClosure = (UITextField) -> Void

extension UIViewController : StoryboardIdentifiable {

    func alertController(title : String?, message : String?, preferredStyle : UIAlertControllerStyle, actions: [UIAlertAction], textFieldConfigures: [textFieldConfigurationClosure]?) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alertController.addAction(action)
        }
        if textFieldConfigures != nil{
            for configureClosure in textFieldConfigures! {
                alertController.addTextField(configurationHandler: configureClosure)
            }
        }
        return alertController
        
    }
    
    func errorAlert(description: String = "An error occured") {
        
        let doneAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            // Do something
        }
        
        /* let firstTextFieldConfigure = { (textfield : UITextField) in
         textfield.placeholder = "Please enter the class of detail"
         }
         
         let secondTextFieldConfigure = {(textfield : UITextField) in
         textfield.placeholder = "Please enter the content of detail"
         }*/
        
        
        let controller = alertController(title: description, message: nil, preferredStyle: .alert, actions: [doneAction], textFieldConfigures: nil)
        
        
        present(controller, animated: true, completion: nil)
        
    }
    
}
