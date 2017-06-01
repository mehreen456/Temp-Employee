//
//  ShiftsCell.swift
//  TempEmployee
//
//  Created by kashif Saeed on 31/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit

class ShiftsCell: UITableViewCell {

    @IBOutlet weak var shiftApplicantImage: UIImageView!
    @IBOutlet weak var shiftStatus: UILabel!
    @IBOutlet weak var shiftRate: UILabel!
    @IBOutlet weak var shiftJobAddress: UILabel!
    @IBOutlet weak var shiftJobTitle: UILabel!
    @IBOutlet weak var shiftDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showMoreOptions(_ sender: Any) {
    }
}
