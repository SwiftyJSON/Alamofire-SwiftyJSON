#Alamofire-SwiftyJSON

Easy way to use both [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Requirements

- iOS 8.0+ / Mac OS X 10.9+
- Xcode 7.0

## Install

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Alamofire-SwiftyJSON'

```

## Usage

```swift
Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
         .responseSwiftyJSON({ (request, response, json, error) in
                     println(json)
                     println(error)
                  })

```
