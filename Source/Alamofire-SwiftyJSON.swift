//
//  AlamofireSwiftyJSON.swift
//  AlamofireSwiftyJSON
//
//  Created by Pinglin Tang on 14-9-22.
//  Copyright (c) 2014年 swiftyJSON. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

// MARK: - Request JSON

//public func requestJSON(method: Alamofire.Method, URLString: Alamofire.URLStringConvertible, parameters: [String: AnyObject]? = nil) -> Alamofire.Request {
//    return Alamofire.request(method, URLString , parameters: parameters, encoding: ParameterEncoding.JSON)
//}

// MARK: - Request

extension Alamofire.Request {

    // MARK: - Swift JSON
    
    public func responseSwiftyJSON(completionHandler: (NSURLRequest, NSHTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void) -> Self {
        return responseSwiftyJSON(completionHandler: completionHandler)
    }

    public func responseSwiftyJSON(priority: Int = DISPATCH_QUEUE_PRIORITY_DEFAULT, queue: dispatch_queue_t? = nil, options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest, NSHTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void) -> Self {
        
        return response(priority: priority, queue: queue, serializer: Alamofire.Request.JSONResponseSerializer(options: options), completionHandler: { (request, response, object, error) in
            dispatch_async(dispatch_get_global_queue(priority, 0), {
                
                var responseJSON: SwiftyJSON.JSON
                
                if (error != nil) {
                    responseJSON = SwiftyJSON.JSON.Null(error)
                } else {
                    responseJSON = SwiftyJSON.JSON(object: object!)
                }
                
                dispatch_async(queue ?? dispatch_get_main_queue(), {
                    completionHandler(self.request, self.response, responseJSON, nil)
                })
            })
        })
    }
}


