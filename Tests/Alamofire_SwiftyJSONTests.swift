//
//  Alamofire_SwiftyJSONTests.swift
//  Alamofire-SwiftyJSONTests
//
//  Created by Pinglin Tang on 14-9-23.
//  Copyright (c) 2014年 SwiftJSON. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class Alamofire_SwiftyJSONTests: XCTestCase {
    
    func testGETRequestJSONResponse() {
        let URL = "http://httpbin.org/get"
        let parameters: Parameters = ["foo": "bar"]
        let expect = expectation(description: "responseSwiftyJSON method should work")
        Alamofire.request(URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseSwiftyJSON { response in
                XCTAssertNotNil(response.request, "request should not be nil")
                XCTAssertNotNil(response.response, "response should not be nil")
                XCTAssertNil(response.error, "result error should be nil")
                XCTAssertEqual(response.value?["args"], SwiftyJSON.JSON(["foo": "bar"] as NSDictionary), "args should be equal")
                expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
