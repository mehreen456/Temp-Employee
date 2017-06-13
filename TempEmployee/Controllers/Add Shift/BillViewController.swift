//
//  BillViewController.swift
//  TempEmployee
//
//  Created by kashif Saeed on 08/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit
import PKHUD

class BillViewController: UIViewController {

    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var totalCharges: UILabel!
    @IBOutlet weak var vatCharges: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var cardCharges: UILabel!
    @IBOutlet weak var tempProvideFee: UILabel!
    @IBOutlet weak var perHourCharges: UILabel!
    
    var shift : Shift!
    var isEditingShift:  Bool?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.perHourCharges.text = "£\(self.shift.getTotalPPH())"
        self.tempProvideFee.text =  "£25"
        self.cardCharges.text =  "£3"
        self.vatCharges.text =  "£22"
        
        let cCharges = self.removeCurrencySignAndConvertToDouble(str: self.cardCharges.text!)
        let fee      = self.removeCurrencySignAndConvertToDouble(str: self.tempProvideFee.text!)
        let vCharges = self.removeCurrencySignAndConvertToDouble(str: self.vatCharges.text!)
        
        
        self.subTotal.text =  "£\(self.shift.getSubtotal(cardCharges: cCharges, tempProvide:fee))"
        
        if let sT = self.subTotal.text{
         let sTotal = self.removeCurrencySignAndConvertToDouble(str: sT)
        self.totalCharges.text =  "\(self.shift.getTotalIncludig(vat:vCharges , subTotal: sTotal))"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCoveredPressed(_ sender: Any) {
        
        if (self.isEditingShift)!{
            self.updateShift(service: CreateShift())
        }else{
        
            self.postShift(service: CreateShift())
        }
    }
    @IBAction func cancelPressed(_ sender: Any) {
        
        self.popToRoot()
    }
    func removeCurrencySignAndConvertToDouble(str : String) -> Double {
       return Double(str.replacingOccurrences(of: "£", with: ""))!
    }
    
    func popToRoot() {
        let _ = self.navigationController?.popToRootViewController(animated: false)
    }
}


extension BillViewController{
    
    func postShift(service:CreateShift)  {
        
        HUD.show(.progress,onView: self.view)
        service.createShift(shift: self.shift!, completionHandler: {result in
            
            switch result {
                
            case .Success(let response):
                    if response.success{
                        HUD.flash(.success, delay: 0.0)
                        self.popToRoot()
                    }else{
                        HUD.flash(.error, delay: 0.0)
                        self.errorAlert(description: response.message)
                }
            case .Failure(let error):
                HUD.flash(.error, delay: 0.0)
                self.errorAlert(description: error.localizedDescription)
            }
        })
    }
    
    func updateShift(service:CreateShift)  {
        
        HUD.show(.progress,onView: self.view)
        service.updateShift(shift: self.shift!, completionHandler: {result in
            
            switch result {
                
            case .Success(let response):
                if response.success{
                    HUD.flash(.success, delay: 0.0)
                    self.popToRoot()
                }else{
                    HUD.flash(.error, delay: 0.0)
                    self.errorAlert(description: response.message)
                }
            case .Failure(let error):
                HUD.flash(.error, delay: 0.0)
                self.errorAlert(description: error.localizedDescription)
            }
        })
    }
    
}
