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

struct Shift {
    var id: NSNumber //"id":1,
    var slot_name: String //"slot_name":"Slot 1",
    var interview_date: String //"interview_date":"25-05-2017",
    var interview_time: String //"interview_time":"10:00 AM",
    var location_name: String //"location_name" : "Manchester",
    var address: String //"address" : "The Old Nags Pub, 19-20 Jacksons Row, Deansgate, Manchester M2 5WD",
    var post_code: String //"post_code" : "M2 5WD",
    var region: String //"region" : "GB-MAN",
}
class Shifts{
    
    var shifts = [Shift]()
     init(jsonDict: JSONDict) {
        
       
            
            let slotsArray = jsonDict["data"] as? [[String:Any]]
            
            if ((slotsArray?.count)! > 0) {
                
                for item in  slotsArray!{
                    
                    
                    let slotObj = Shift(id:item["id"] as! NSNumber , slot_name: item["slot_name"] as! String, interview_date: item["interview_date"] as! String, interview_time: item["interview_time"] as! String, location_name: item["location_name"] as! String, address: item["address"] as! String, post_code: item["post_code"] as! String, region: item["region"] as! String)
                    
                    shifts.append(slotObj)
                }
                
            }
        
    }
}

struct ShiftsService {
    

    func fetchInterviewSlots(for user_id:Int ,completionHandler: @escaping (Result<Shifts> ) -> Void) {
        
        NetworkManager.callServer(with_request: TemProvideRouter.get(user_id), completionHandler: {result in
            
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
