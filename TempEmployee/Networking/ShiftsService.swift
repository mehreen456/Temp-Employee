//
//  ShiftsService.swift
//  TempEmployee
//
//  Created by kashif Saeed on 01/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftyUserDefaults

struct Licence{
    
     var id: NSNumber
     var license_name : String
    

}
struct Shift  {
    
    var role: String?
    var from_time: String?
    var interview_time: String?
    var shift_hours: String?
    var address: String?
    var price_per_hour: String?
    var shift_date: String?
    
     var reporting_to: String?
     var phone: String?
     var details: String?
     var special_info: String?
     var site_instructions: String?
     var required_licenses: [Licence]
        
}
class Shifts : Meta{
    
    var shifts = [Shift]()
     override init(jsonDict: JSONDict) {
        
        super.init(jsonDict: jsonDict)
        
        if self.success{
            let shiftsArray = jsonDict["data"] as? [[String:Any]]
            
            if ((shiftsArray?.count)! > 0) {
                
                for shift in  shiftsArray!{
                    
                    let requiredLicenceArray = shift["required_licenses"] as? [[String:Any]]
                    
                    var licenceArray = [Licence]()
                    if requiredLicenceArray != nil {
                   
                        for licence in requiredLicenceArray!{
                       
                            let licenceObject = Licence(id: licence["id"] as! NSNumber, license_name: licence["license_name"] as! String)
                        
                        licenceArray.append(licenceObject)
                   
                        }
                    }
                    let ShiftObject = Shift(role: shift["role"] as? String, from_time: shift["from_time"] as? String, interview_time: shift["interview_time"] as? String, shift_hours: shift["shift_hours"] as? String, address: shift["address"] as? String, price_per_hour: shift["price_per_hour"] as? String, shift_date: shift["shift_date"] as? String, reporting_to: shift["reporting_to"] as? String, phone: shift["phone"] as? String, details: shift["details"] as? String, special_info: shift["special_info"] as? String, site_instructions: shift["site_instructions"] as? String, required_licenses:  licenceArray)
                    
                    shifts.append(ShiftObject)
                }
                
            }
        
    
        }
    }
}

struct ShiftsService {
    

    func fetchMyShifts(with completionHandler: @escaping (Result<Shifts> ) -> Void) {
        
        NetworkManager.callServer(with_request: TemProvideRouter.get, completionHandler: {result in
            
            switch result {
                
            case .Success(let response):
                print (response )
                let object = Shifts(jsonDict: response)
                print("parsed data = ", object)
                completionHandler(.Success(object))
                
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
            
        })
        
    }
    
    /*func bookSlot(with id:Int ,completionHandler: @escaping (Result<Meta> ) -> Void) {
        
        NetworkManager.callServer(with_request: TemProvideRouter.postSlotId(Defaults[.jobSeekerID]!, id), completionHandler: {result in
            
            switch result {
                
            case .Success(let response):
                print (response )
                let object = Meta(jsonDict: response)
                print("parsed data = ", object)
                completionHandler(.Success(object))
                /*let success = response["meta"]!["success"] as? Bool
                 if success! {
                 
                 
                 }else{
                 
                 }*/
                
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
            
        })
        
    }*/
    
    
}
