//
//  API.swift
//  TestTask
//
//  Created by Karun Aggarwal on 31/08/17.
//  Copyright © 2017 Squareloops. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class API: NSObject {

/// Base URL
    class func baseurl() -> String {
        return "https://api.themoviedb.org/3/"
    }
/// API Key
    class func apikey() -> String {
        return "api_key=879bfb181e8499806c6037dab6e20786"
    }
/// API Type
    class func movie() -> String {
        return API.baseurl() + "movie/"
    }
/// API Method names
    class var topRated: String { return API.movie() + "top_rated?" + API.apikey() }
    class var popular: String  { return API.movie() + "popular?" + API.apikey() }
    class var newArrival: String { return API.movie() + "now_playing?" + API.apikey() }
    
/// Check for Internet Connectivity
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
/// API call for GET Method
    class func getApi(controller: UIViewController, method: String, param: NSDictionary, completion: @escaping (_ result: NSDictionary?) ->()) {
    /// Check for internet connectivity before calling webservice or api
        if isConnectedToInternet() == false {
            controller.present(Common.share.alertMessage("Internet connection seems unavailable."), animated: true, completion: nil)
            completion(nil)
            return
        }
        Common.share.showActivityIndicator(controller.view)
        Alamofire
            .request(method, method: .get, parameters: param as? Parameters)    /// Pass method name & type with paramaters
            .validate(statusCode: 200..<300)                                    /// Validate API response status
            .responseJSON(completionHandler: { (response) in                    /// response return from webservice or api
                print(response.response!)
                print(response.result.value.debugDescription)
                Common.share.hideActivityIndicator()
                switch response.result {
                case .success:                                                  /// Success Response
                    let result = response.result.value as? NSDictionary
                    if result != nil {
                        completion(result)
                    } else {
                        controller.present(Common.share.alertMessage("No data available."), animated: true, completion: nil)
                        completion(nil)
                    }
                    break
                case .failure:                                                  /// Failure Response
                    controller.present(Common.share.alertMessage("Internal error! Something went wrong. Try again later."), animated: true, completion: nil)
                    completion(nil)
                    break
                }
        })
    }
}
