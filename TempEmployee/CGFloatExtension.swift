//
//  CGFloatExtension.swift
//  TempEmployee
//
//  Created by kashif Saeed on 13/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    func roundDown() -> CGFloat {
        return CGFloat(floor(Double(self)))
    }
    func roundUp() -> CGFloat
    { return CGFloat(ceil(Double(self)))
    }
}
