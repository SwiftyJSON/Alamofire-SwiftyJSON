# Alamofire-SwiftyJSON ![](https://travis-ci.org/SwiftyJSON/Alamofire-SwiftyJSON.svg?branch=master)

An extension to make serializing [Alamofire](https://github.com/Alamofire/Alamofire)'s response with [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) easily.

⚠️ **To use with Swift 3.x please ensure you are using >= `2.0.0`** ⚠️

⚠️ **To use with Swift 4.x please ensure you are using >= `3.0.0`** ⚠️

## Swift version

Alamofire-SwiftyJSON | Swift version | Alamofire | SwiftyJSON
-------------        | --------------| ----------| ----------
2.x                  | Swift 3.x     |    4.x    |  3.x
3.x                  | Swift 4.x     |    4.5.x  |  4.x

## Requirements

- iOS 8.0+ / Mac OS X 10.9+
- Xcode 8.0+
- Swift 3.0+

## Install

[CocoaPods](https://cocoapods.org/):

```ruby
pod 'Alamofire-SwiftyJSON'
```

[Carthage](https://github.com/Carthage/Carthage):

```
github "SwiftyJSON/Alamofire-SwiftyJSON" "master"
```

## Usage

```swift
Alamofire.request(URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
         .responseSwiftyJSON { dataResponse in
                     print(dataResponse.request)
                     print(dataResponse.response)
                     print(dataResponse.error)
                     print(dataResponse.value)
                  })
```
