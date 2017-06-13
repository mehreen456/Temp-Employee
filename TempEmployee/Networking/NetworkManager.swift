//
//  NetworkManager.swift
//  Temp Provide
//
//  Created by kashif Saeed on 15/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import Foundation
import Alamofire


typealias SuccessHandler<T> = (Result<T>) -> Void



enum Result<T> {
    case Success(T)
    case Failure(Error)
}

class NetworkManager {

    static let shared = NetworkManager()
    //typealias completion = (_ response : Any?, _ error :NetworkError) -> Void
    

}
extension NetworkManager {
    
    static func callServer(with_request request: URLRequestConvertible, completionHandler: @escaping (Result<[String:Any]>) -> Void){
        
        Alamofire.request(request).responseJSON { response in
            if let errorData = response.result.error {
                completionHandler(.Failure(errorData))
                return
            }
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as?  [String: Any]
                    completionHandler(.Success(json!))
                }catch{
                    
                }
            }

        }
        
    }
}



