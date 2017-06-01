//
//  UserDefaults.swift
//  Temp Provide
//
//  Created by kashif Saeed on 19/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import SwiftyUserDefaults


extension UserDefaults {
    subscript(key: DefaultsKey<[[String: String]]>) -> [[String: String]] {
        get { return unarchive(key) ?? [["":""]] }
        set { archive(key, newValue) }
    }
}

extension DefaultsKeys {
    // User Data fields to presist
    static let accessToken = DefaultsKey<String?>(Constants.Employer.accessToken)
    static let accessTokenExpiresIn = DefaultsKey<Int>(Constants.Employer.accessTokenExpireIn)
    static let licenceInfoPosted = DefaultsKey<Bool>(Constants.Employer.licencePosted)
    static let interviewDate = DefaultsKey<String?>(Constants.Employer.scheduledInterviewDate)
    static let interviewTime = DefaultsKey<String?>(Constants.Employer.scheduledInterviewTime)
    static let interviewAddress = DefaultsKey<String?>(Constants.Employer.scheduledInterviewAddress)
    // Setting App Root VC flags
    static let hasUserRegistered = DefaultsKey<Bool>(Constants.Employer.Registered)
    static let hasUserSIADetailsUploaded = DefaultsKey<Bool>(Constants.Employer.LicencesUploaded)
    static let hasUserUploadedProfilePic = DefaultsKey<Bool>(Constants.Employer.ProfilePicUploaded)
    static let hasUserAccountDetailsRegistered = DefaultsKey<Bool>(Constants.Employer.AccountDetailsUploaded)
    static let hasUserSelectedASlot = DefaultsKey<Bool>(Constants.Employer.InterviewSlotBooked)
}
