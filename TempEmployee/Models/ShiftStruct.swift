//
//  ShiftStruct.swift
//  TempEmployee
//
//  Created by kashif Saeed on 09/06/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import AFDateHelper

public enum ShiftStatus :Int{
    case pending = 0
    case covered = 1
    case completed = 2

}

struct Shift  {
    
    var id: Int!
    var assigned_job_seeker_id: Int?
    var role: String?
    var from_time: String?
    var interview_time: String?
    var shift_hours: String?
    var address: String?
    var price_per_hour: String?
    var shift_date: String?
    var lat: Double?
    var lng: Double?
    
    var reporting_to: String?
    var phone: String?
    var details: String?
    var special_info: String?
    var site_instructions: String?
    var required_licenses: [Licence]
    var jobSeeker: JobSeeker?
    var assign_status : ShiftStatus!
    var created_at : String!
    
    init(role:String?,from_time: String?, interview_time: String?,shift_hours: String?,address: String?,price_per_hour: String?,shift_date: String?,reporting_to: String?,phone: String?,details: String?,special_info: String?,site_instructions: String?,required_licenses: [Licence],id:Int,assigned_job_seeker_id:Int?, lat: Double, lng:Double,assign_status:ShiftStatus!, created_at:String?) {
        
        self.id = id
        self.assigned_job_seeker_id = assigned_job_seeker_id
        self.role = role
        self.from_time = from_time
        self.interview_time = interview_time
        self.shift_hours = shift_hours
        self.shift_date = shift_date
        self.address = address
        self.price_per_hour = price_per_hour
        self.lat = lat
        self.lng = lng
        self.reporting_to = reporting_to
        self.phone = phone
        self.details = details
        self.special_info = special_info
        self.site_instructions = site_instructions
        self.required_licenses = required_licenses
        self.assign_status = assign_status
        self.created_at = created_at
        
    }
    
    init(role:String?,from_time: String?,shift_hours: String?,address: String?,price_per_hour: String?,shift_date: String?,required_licenses: [Licence] , latitude:Double, longitude:Double) {
        
        self.role = role
        self.from_time = from_time
        self.shift_hours = shift_hours
        self.shift_date = shift_date
        self.address = address
        self.price_per_hour = price_per_hour
        self.required_licenses = required_licenses
        self.lat = latitude
        self.lng = longitude
    }
    
    func getTotalPPH() -> Double {
        let pph = Double(self.price_per_hour!)
        let hours = Double(self.shift_hours!)
        return (pph! * hours!)
    }
    func getSubtotal(cardCharges:Double,tempProvide fee:Double) -> Double {
      
        
        return (self.getTotalPPH() + cardCharges + fee)
        
    }
    func getTotalIncludig(vat:Double , subTotal : Double) -> Double {
        
        return (subTotal + vat)
    }
    
    func isPostedWithinAnHour() -> DateComponents? {
       
        
       let shiftCreatedAt =  Date.init(fromString: self.created_at, format: .custom("yyyy-MM-dd HH:mm:ss"), timeZone: TimeZoneType.utc, locale: Locale.init(identifier: "en_GB"))
        
        let currentDate = Date.init()
        
        return  Calendar.current.dateComponents([.hour,.minute], from: shiftCreatedAt!, to: currentDate)
 
    }
}
