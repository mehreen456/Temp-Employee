//
//  FooterView.swift
//  TempEmployee
//
//  Created by kashif Saeed on 01/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit

class FooterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet open var newShiftButton: UIButton!
    @IBAction func confirmPressed(_ sender: UIButton) {
        
        print(sender)
    }
    
}
