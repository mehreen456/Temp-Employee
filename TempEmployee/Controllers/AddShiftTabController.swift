//
//  AddShiftTabController.swift
//  TempEmployee
//
//  Created by kashif Saeed on 13/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit

class AddShiftTabController: UIViewController {

    
    var addShiftVC = AddShiftController()
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard.init(name: "AddShift", bundle: nil)
         self.addShiftVC  = storyboard.instantiateViewController()
        addChildViewController(self.addShiftVC)
        view.addSubview(self.addShiftVC.view)
        addShiftVC.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addShiftVC.clearPrefilledData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
