//
//  AddShiftController.swift
//  TempEmployee
//
//  Created by kashif Saeed on 04/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import DropDown
import SwiftValidator
import AFDateHelper
import PKHUD

class AddShiftController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rollField: UITextField!
    @IBOutlet weak var address: UITextView!
    

    var price : Int? {
        
        didSet{
            
            self.cell?.pricePerHourField.text = "£\(price!)"
        }
    }
    
    var hours : Int? {
    
    didSet{
    
        self.cell?.hoursField.text = "\(hours!) hr"
    }
    }
    
    var licecnceField : UITextField!
    var textFieldTapRecognizer :UITapGestureRecognizer?
    var cell : AddShiftCell?
    var licences  =  [Licence]()
    var selectedLicences  =  [Licence]()
    
    let dropDown = DropDown()
    let validator = Validator()
    let timeArray = Constants.Shift.time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.dataSource   = self
        self.tableView.delegate     = self
        
        
        //self.tagView.delegate = self
        //self.tagView.dataSource = self
        self.FetchAllSIALicences(service: LicenceService())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.price = Constants.Shift.defaultPrice
        self.hours = Constants.Shift.defaultHours
    }

}
extension AddShiftController: UITableViewDataSource, UITableViewDelegate ,ValidationDelegate , UITextFieldDelegate,UIGestureRecognizerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier:"AddShiftCell" , for: indexPath) as! AddShiftCell
       
       
        cell.pricePerHourField.text = "£\(Constants.Shift.defaultPrice)"
        cell.hoursField.text = "\(Constants.Shift.defaultHours) hr"
        // Validation Rules are evaluated from left to right.
        validator.registerField(cell.jobAddressTxtView as ValidatableField , errorLabel:cell.addressErrorLabel  , rules: [RequiredRule()])
        
        validator.registerField(cell.jobRollField , errorLabel:cell.rollErrorLabel, rules: [RequiredRule()])
        validator.registerField(cell.licenceRequiredField , errorLabel:cell.requiredLicenceErrorLabel, rules: [RequiredRule()])
        validator.registerField(cell.startTimeField , errorLabel:cell.startTimeErrorLabel, rules: [RequiredRule()])
        validator.registerField(cell.hoursField , errorLabel:cell.hoursErrorLabel, rules: [RequiredRule()])
        validator.registerField(cell.dateField , errorLabel:cell.dateErrorLabel, rules: [RequiredRule()])
        validator.registerField(cell.pricePerHourField , errorLabel:cell.priceErrorLabel, rules: [RequiredRule()])
        
        
        //cell.shiftStatus = shift.
        cell.nextButton.addTarget(self, action: #selector(nextButtonPressed),for: .touchUpInside)
        cell.cancelButton.addTarget(self, action: #selector(cancelButtonPressed),for: .touchUpInside)
        
        cell.addLicenceButton.addTarget(self, action: #selector(addLicence(_:)),for: .touchUpInside)
        
        cell.startTimeDropDownButton.addTarget(self, action: #selector(showStartDropDownMenu(_:)),for: .touchUpInside)
        cell.dateDropDownButton.addTarget(self, action: #selector(showDateDropDownMenu(_:)),for: .touchUpInside)
        
        cell.hoursMinusButton.addTarget(self, action: #selector(minusHours),for: .touchUpInside)
        cell.hoursPlusButton.addTarget(self, action: #selector(plusHours),for: .touchUpInside)
        
        cell.pricePlusButton.addTarget(self, action: #selector(plusPrice),for: .touchUpInside)
        cell.priceMinusButton.addTarget(self, action: #selector(minusPrice),for: .touchUpInside)
        
        cell.licenceRequiredField.delegate = self
       // cell.jobAddressTxtView.delegate = self
        cell.jobRollField.delegate = self
        cell.hoursField.delegate = self
        cell.pricePerHourField.delegate = self
        cell.dateField.delegate = self
        cell.startTimeField.delegate = self

        self.licecnceField = cell.licenceRequiredField
        
        
        textFieldTapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(textFieldTapGestureAction(_:)))
        textFieldTapRecognizer?.delegate = self
             cell.licenceRequiredField.addGestureRecognizer(textFieldTapRecognizer!)
        
        self.cell = cell
        
        return cell
    }
    
    func textFieldTapGestureAction(_ sender : UITapGestureRecognizer)  {
        print("move to next step")
        
        dropDown.anchorView = self.licecnceField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        dropDown.show()
        
    }
    
    func nextButtonPressed()  {
        print("move to next step")
        validator.validate(self)
    }
    
    func cancelButtonPressed()  {
        print("move to next step")
    }
    
    func addLicence(_ sender : UIButton)  {
       

        let namesArray = self.licences.flatMap{$0.license_name}
        let dropDown =  self.showDropDownMenu(onView: sender, dataForDropDownMenu:namesArray)
        dropDown.show()
        
        // Action triggered on selection
        dropDown.selectionAction = {  (index: Int, item: String) in
            let  filteredArray = self.selectedLicences.filter{$0.id.intValue == self.licences[index].id as Int}
            print(filteredArray)
            if filteredArray.count == 1{
                return
            }
            self.cell?.licenceRequiredField.text = item
            
            let selectedLicenceObject = self.licences[index]
            var index = self.selectedLicences.count
            index -= 1
            self.cell?.licenceView.addSubview((self.cell?.licenceView.addTagView(licence: selectedLicenceObject, callBackHandler: self, callback: #selector(self.removeLicence(_:)), lastTagIndex:index  , previousTags :(self.cell?.licenceView.subviews)! ))!)
            
            
            self.selectedLicences.append(selectedLicenceObject)
            
        }
    }
    
    func showStartDropDownMenu(_ sender : UIButton)  {
        print("move to next step")
        
        let dropDown =  self.showDropDownMenu(onView: sender, dataForDropDownMenu: self.timeArray)
        dropDown.show()
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.cell?.startTimeField.text = item
        }
        
        
        
    }
    func showDateDropDownMenu(_ sender : UIButton)   {
        print("move to next step")
       
        let calendar    =   Calendar(identifier: .gregorian)
        let startDate   =   Date.init(timeIntervalSinceNow: 0)
        let endDate     =   Date.init(timeIntervalSinceNow: 24*60*60*7-1)
        
       let dateRange = calendar.dateRange(start: startDate, end: endDate, stepUnits: .day, stepValue: 1)
        
        let datesInRange = Array(dateRange)
    
        let stringDates = datesInRange.map{$0.toString(format:DateFormatType.custom("dd MMMM yyyy"))}
        print(stringDates)
       let dropDown =  self.showDropDownMenu(onView: sender, dataForDropDownMenu: stringDates)
        
        dropDown.show()
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
        
            self.cell?.dateField.text = item
        }
    }
    func minusHours()  {
        self.hours! -= 1
    }
    func plusHours()  {
        self.hours! += 1
    }
    func plusPrice()  {
        self.price! += 1
    }
    func minusPrice()  {
       self.price! -= 1
    }
    
    func showDropDownMenu(onView:UIView , dataForDropDownMenu : [String]) -> DropDown {
        
        self.tableView.endEditing(true)
        dropDown.anchorView = onView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = dataForDropDownMenu
        
        return dropDown
       
        }
    
    func removeLicence(_ sender:UIButton)  {
        self.selectedLicences = self.selectedLicences.filter{$0.id.intValue != sender.tag}
        self.cell?.licenceRequiredField.text = ""
        sender.superview?.removeFromSuperview()

    }
    func validationSuccessful() {
        // after user have corrected all the fields remove the error labels text
        // removeErrorLabelText()
        
        
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (_, error) in errors {
            /* if let field = field as? UITextField {
             field.layer.borderColor = UIColor.red.cgColor
             field.layer.borderWidth = 1.0
             }*/
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
            error.errorLabel?.textColor = UIColor.red
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        if textField == self.licecnceField{
            self.resignFirstResponder()
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //Return YES if it's textFieldTapRecognizer else return NO.
            return (gestureRecognizer == textFieldTapRecognizer);
    }
   
}

// NETWORKING
//
//
extension AddShiftController{
    
    
    
    func FetchAllSIALicences(service:LicenceService) {
        
        HUD.show(.progress,onView: self.view)
        
        service.fetchSIALicence(with: {result in
            
            switch result{
                
            case .Success(let response):
                print(response)
                HUD.flash(.success, delay: 0.0)
                if response.success{
                    self.licences = response.licences
                }else{
                    HUD.flash(.error, delay: 0.0)
                    self.errorAlert(description: response.message)
                }
            case .Failure(let error):
                HUD.flash(.error, delay: 0.0)
                self.errorAlert(description: error.localizedDescription)
                print(error)
            }
            
            
        })
    }
}
