//
//  StringExtension.swift
//  TempEmployee
//
//  Created by kashif Saeed on 06/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin ,attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
    }
    
    
}
