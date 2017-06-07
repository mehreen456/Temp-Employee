//
//  GlobalVariables.swift
//  Temp Provide
//
//  Created by kashif Saeed on 19/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation

struct Constants {
    
    static let appName: String                          = "Temp Employee"
    
    struct Notifications {
        
        static let licenceDetailsAdded: String          = "licenceDetailsAdded"
        static let licenceSuccessfullyUploaded: String  = "licenceSuccessfullyUploaded"
    }
    
    struct EndPoints {
        struct Post {
            static let Login : String                   = "employers/login"
            static let LicenceDetails : String          = "employers/licenseDetails"
            static let ProfilePic : String              = "employers/uploadImage"
            static let PaymentDetails : String          = "employers/paymentDetails"
        }
        
        
        struct Get {
            
            static let shifts : String                      = "employers/shifts"
            static let licences : String                    = "licenseTypes"
        }
        /**
         Repeats a string `times` times.
         
         - Parameter id:   The job seekeer id.
         - Parameter endpoint: GET / POST Method name.
         - Returns: A completed URL string got registered job seeker.
         */
        
        var getAllInterviewSlots: (Int,String) -> String = EndPoints.createJobseekerURL
        
        static func createJobseekerURL(userID:Int,endpoint:String) -> String {
            
            return "jobSeekers/\(userID)/\(endpoint)"
        }
    }
    
    struct Employer {
        static let accessToken : String                             = "access_token"
        static let accessTokenExpireIn : String                     = "accessTokenExpireIn"
        static let licencePosted : String                           = "licencePosted"
        
        
         static let Registered : String                 = "userRegistered"
         static let LicencesUploaded : String           = "licencesUploaded"
         static let ProfilePicUploaded : String         = "profilePicUploaded"
         static let AccountDetailsUploaded : String     = "accountDetailsUploaded"
         static let InterviewSlotBooked : String        = "interviewSlotBooked"
        
        static let scheduledInterviewDate : String      = "scheduledInterviewDate"
        static let scheduledInterviewTime : String      = "scheduledInterviewTime"
        static let scheduledInterviewAddress : String   = "scheduledInterviewAddress"
    }
    
    struct licenceConstants {
        static let id : String                          = "id"
        static let title : String                       = "title"
        
    }
    
    struct S3Credentials {
        static let secretkey : String                   = "7mKulZ++s1toDiMgjVUcKzQv3dm+CrKBk9BSgzNW"
        static let accessKey : String                   = "AKIAJIXK6GZMBVX5FWDA"
        static let S3_BUCKET_NAME                       =  "gl-lms"
        static let S3_BUCKET_URL                        = "http://gl-lms.s3.amazonaws.com/"
        static let profilePic: String                   = "Profile.png"
        
    }
    
    struct Shift {
        static let defaultPrice : Int                        = 8
        static let defaultHours : Int                        = 8
        static let time : [String]                           = ["1AM","2AM","3AM","4AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM","12AM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12PM"]
    }
}
