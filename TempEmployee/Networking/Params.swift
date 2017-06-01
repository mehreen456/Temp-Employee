//
//  Params.swift
//  Temp Provide
//
//  Created by kashif Saeed on 14/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class Params {
    
    public static func paramsForLogin(email : String = "admin@train4security.com" , password:String) -> [String:Any] {
        
        
        
        return [
            "username": email,
            "password": password,
            "client_id": "1",
            "client_secret": "test",
            "grant_type": "password"
            ]
    }
    
    public static func paramsForPostLicenceDetails(info : [[String:String]]) -> [String:Any] {
        
        
        return [
            "job_seeker_id":Defaults[.accessToken] ?? "",
            "license_details":info
        ]
    }
    
    public static func paramsForPostProfilePic(info : String) -> [String:Any] {
        
        
        return [
            "job_seeker_id":Defaults[.accessToken] ?? "",
            "image_string":info
        ]
    }
    public static func paramsForPostPaymentDetails(accountName : String,accountNumber:String,sortCode:String) -> [String:Any] {
        
        
        return [
            "job_seeker_id":Defaults[.accessToken] ?? "",
            "account_name":accountName,
            "account_number":accountNumber,
            "sort_code":sortCode
        ]
    }
    
    public static func paramsForSlotBooking(slotID : Int) -> [String:Any] {
        
        
        return [
            "job_seeker_id":Defaults[.accessToken] ?? "",
            "slot_id":slotID
        ]
    }
}
