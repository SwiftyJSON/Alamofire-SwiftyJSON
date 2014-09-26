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

// MARK: - Request for Swift JSON

extension Alamofire.Request {
    
    /**
    Adds a handler to be called once the request has finished.
    
    :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
    
    :returns: The request.
    */
    public func responseSwiftyJSON(completionHandler: (NSURLRequest, NSHTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void) -> Self {
        return responseSwiftyJSON(completionHandler: completionHandler)
    }
    
    /**
    Adds a handler to be called once the request has finished.
    
    :param: priority The dispatch priority / quality of service used to process the response handler. `DISPATCH_QUEUE_PRIORITY_DEFAULT` by default.
    :param: queue The queue on which the completion handler is dispatched.
    :param: options The JSON serialization reading options. `.AllowFragments` by default.
    :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
    
    :returns: The request.
    */
    public func responseSwiftyJSON(priority: Int = DISPATCH_QUEUE_PRIORITY_DEFAULT, queue: dispatch_queue_t? = nil, options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest, NSHTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void) -> Self {
        
        return response(priority: priority, queue: queue, serializer: Alamofire.Request.JSONResponseSerializer(options: options), completionHandler: { (request, response, object, error) in
            dispatch_async(dispatch_get_global_queue(priority, 0), {
                
                var responseJSON: SwiftyJSON.JSON
                
                if error != nil {
                    responseJSON = SwiftyJSON.JSON.Null(error)
                } else {
                    if object != nil {
                        responseJSON = SwiftyJSON.JSON(object: object)
                    } else {
                        responseJSON = SwiftyJSON.JSON.Null(nil)
                    }
                }
                
                dispatch_async(queue ?? dispatch_get_main_queue(), {
                    completionHandler(self.request, self.response, responseJSON, nil)
                })
            })
        })
    }
}


