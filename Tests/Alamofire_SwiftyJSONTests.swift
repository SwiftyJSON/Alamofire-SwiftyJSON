//
//  Alamofire_SwiftyJSONTests.swift
//  Alamofire-SwiftyJSONTests
//
//  Created by Pinglin Tang on 14-9-23.
//  Copyright (c) 2014年 SwiftJSON. All rights reserved.
//

import UIKit
import XCTest
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class Alamofire_SwiftyJSONTests: XCTestCase {
    
    func testJSONResponse() {
        let URL = "http://httpbin.org/get"
        let expectation = expectationWithDescription("\(URL)")
        
        Alamofire.request(.GET, URL, parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, responseJSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertNil(error, "error should be nil")
                XCTAssertEqual(responseJSON["args"], SwiftyJSON.JSON(["foo": "bar"] as NSDictionary), "args should be equal")
        }
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
}
