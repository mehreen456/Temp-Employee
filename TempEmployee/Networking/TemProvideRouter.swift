//
//  TodoRouter.swift
//  grok101
//
//  Created by Christina Moulton on 2016-10-29.
//  Copyright © 2016 Teak Mobile Inc. All rights reserved.
//

import Foundation
import Alamofire

enum TemProvideRouter: URLRequestConvertible {
    
    
  static let baseURLString = "https://devapi.temprovide.com/v1/employers/"
  //static let authenticationToken = "Basic xxx"
    
  case get(Int)
  case login(String,String)
  case postLicenceInfo([[String:String]])
  case postProfilePic(String)
  case postPaymentDetails(String,String,String)
  case postSlotId(Int,Int)
  func asURLRequest() throws -> URLRequest {
   
    // create a variable of type HTTPMethod to set Api call type
    
    var method: HTTPMethod {
      switch self {
      case .get:
        return .get
      case .login,.postLicenceInfo,.postProfilePic,.postPaymentDetails,.postSlotId:
        return .post
      }
    }
    
    // Params to be added in the api call
    // In case of GET and DELETE call return nil
    let params: ([String: Any]?) = {
      switch self {
      case .get:
        return nil
      case .login(let email, let password):
        return (Params.paramsForLogin(email: email, password: password))
      case .postLicenceInfo(let details):
        return (Params.paramsForPostLicenceDetails(info: details))
      case .postProfilePic(let path):
        return (Params.paramsForPostProfilePic(info: path))
      case .postPaymentDetails(let name,let number,let sortcode):
        return (Params.paramsForPostPaymentDetails(accountName: name, accountNumber: number, sortCode: sortcode))
      case .postSlotId(_ , let slotID):
        return (Params.paramsForSlotBooking(slotID: slotID))
      }
    }()
    let url: URL = {
      // build up and return the URL for each endpoint
      let relativePath: String?
      switch self {
      case .get(let number):
        relativePath = Constants.EndPoints.createJobseekerURL(userID: number, endpoint: Constants.EndPoints.Get.slots)
      case .login:
        relativePath = Constants.EndPoints.Post.Login
      case .postLicenceInfo:
        relativePath = Constants.EndPoints.Post.LicenceDetails
      case .postProfilePic:
        relativePath = Constants.EndPoints.Post.ProfilePic
      case .postPaymentDetails:
        relativePath = Constants.EndPoints.Post.PaymentDetails
      case .postSlotId(let jobseekerID , _):
        relativePath = Constants.EndPoints.createJobseekerURL(userID:jobseekerID, endpoint: Constants.EndPoints.Get.slots)
      }
        
      var url = URL(string: TemProvideRouter.baseURLString)!
      if let relativePath = relativePath {
        url = url.appendingPathComponent(relativePath)
      }
      return url
    }()
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //urlRequest.timeoutInterval = TimeInterval(10 * 1000)
    
    let encoding = JSONEncoding.default
    return try encoding.encode(urlRequest, with: params)
  }
}