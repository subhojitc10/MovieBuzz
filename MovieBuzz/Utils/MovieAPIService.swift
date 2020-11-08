//
//  MovieAPIService.swift
//  MovieBuzz
//
//  Created by GOQii-Subhojit on 06/11/20.
//  Copyright © 2020 SpcaeTown-Subhojit. All rights reserved.
//

import UIKit
import Alamofire

let baseEndpoint = "https://api.themoviedb.org/3/trending/"

class MovieAPIService {
    class func request(urlString:String,method:HTTPMethod, data:Any? = nil, completion:@escaping (_ data:NSDictionary, _ error:Error?) -> ()){
        let endpoint = baseEndpoint + urlString
        
        let headerData = ["content-type":"application/json", "accept":"application/json"]
        let header = HTTPHeaders(headerData)
        
        AF.request(endpoint, method: method, parameters: data as? Parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print("Response of \(endpoint) =====> \(response)")
            if let result = response.value as? NSDictionary {
                completion(result,nil)
            }
        }
        
        
        
    }
}
