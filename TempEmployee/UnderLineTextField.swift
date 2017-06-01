//
//  UITextField.swift
//  Temp Provide
//
//  Created by kashif Saeed on 03/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import UIKit

class UnderLineTextField: UITextField {
    
    
    override open func draw(_ rect: CGRect) {
        
        let startingPoint:CGPoint =   CGPoint(x: rect.minX, y:rect.maxY-1)
        let endingPoint:CGPoint =   CGPoint(x: rect.maxX, y:rect.maxY-1)
        
        let path :UIBezierPath = UIBezierPath.init()
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 1
        UIColor.init(colorLiteralRed:211.0/255.0 , green: 210/255.0, blue: 214/255.0, alpha: 1.0).setStroke()
        path.stroke()
    }
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
