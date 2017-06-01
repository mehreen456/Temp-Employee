//
//  TextField.swift
//  TempEmployee
//
//  Created by kashif Saeed on 30/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
    
    @IBInspectable var placeHolderFont: UIFont? {
        get {
            return self.placeHolderFont
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSFontAttributeName: newValue!])
        }
    }
}
