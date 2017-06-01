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
            static let Login : String                   = "login"
            static let LicenceDetails : String          = "licenseDetails"
            static let ProfilePic : String              = "uploadImage"
            static let PaymentDetails : String          = "paymentDetails"
        }
        
        
        struct Get {
            
            static let slots : String                   = "slots"
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
        static let accessToken : String                             = "accessToken"
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
    
}
