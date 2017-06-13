//
//  UIView.swift
//  Temp Provide
//
//  Created by kashif Saeed on 03/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//


import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
}
extension UIView{
    
    func addTagView(licence : Licence ,callBackHandler : AnyObject, callback:Selector ,lastTagIndex : Int,previousTags:[UIView]) -> UIView {
        
        let tagView = Bundle.main.loadNibNamed("tagView", owner: self, options: nil)?.first as! UIView
        let label = tagView.viewWithTag(400) as! UILabel
        let cancelButton = tagView.viewWithTag(401) as! UIButton
        cancelButton.addTarget(callBackHandler, action: callback ,for: .touchUpInside)
        label.text = licence.license_name
        label.tag = licence.id as Int
        cancelButton.tag = licence.id as Int
        let calculatedWidth = licence.license_name.width(withConstrainedHeight: label.frame.size.height, font: label.font) + cancelButton.frame.size.width + 5
        
        //let row = previousTags.count / 2
        //let Y = (row * Int(label.frame.size.height))
        
        if (previousTags.count == 0){
            tagView.frame = CGRect(x: 15, y:5 , width:calculatedWidth, height: label.frame.size.height)
        }else {
            
            let previousTagMaximumX = previousTags[lastTagIndex].frame.maxX
            let previousTagY = previousTags[lastTagIndex].frame.origin.y
            
            if ((previousTagMaximumX + calculatedWidth) < self.frame.size.width ){
            tagView.frame = CGRect(x: previousTagMaximumX+10, y: previousTagY , width:calculatedWidth, height: label.frame.size.height)
        
            }else {
           
                tagView.frame = CGRect(x: 0, y:previousTagY + label.frame.size.height + 10, width:calculatedWidth, height: label.frame.size.height)
       
            }
        }
        return tagView
    }

}
