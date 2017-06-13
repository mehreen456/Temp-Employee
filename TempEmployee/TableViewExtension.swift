//
//  TableViewExtension.swift
//  TempEmployee
//
//  Created by kashif Saeed on 09/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func indexPath(of view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: location)
    }
}
