import Foundation
import Alamofire
import SwiftyJSON

public final class SwiftyJSONResponseSerializer: ResponseSerializer {
  public let dataPreprocessor: DataPreprocessor
  public let emptyResponseCodes: Set<Int>
  public let emptyRequestMethods: Set<HTTPMethod>
  /// `JSONSerialization.ReadingOptions` used when serializing a response.
  public let options: JSONSerialization.ReadingOptions
  
  /// Creates an instance with the provided values.
  ///
  /// - Parameters:
  ///   - dataPreprocessor:    `DataPreprocessor` used to prepare the received `Data` for serialization.
  ///   - emptyResponseCodes:  The HTTP response codes for which empty responses are allowed. `[204, 205]` by default.
  ///   - emptyRequestMethods: The HTTP request methods for which empty responses are allowed. `[.head]` by default.
  ///   - options:             The options to use. `.allowFragments` by default.
  public init(dataPreprocessor: DataPreprocessor = SwiftyJSONResponseSerializer.defaultDataPreprocessor,
              emptyResponseCodes: Set<Int> = SwiftyJSONResponseSerializer.defaultEmptyResponseCodes,
              emptyRequestMethods: Set<HTTPMethod> = SwiftyJSONResponseSerializer.defaultEmptyRequestMethods,
              options: JSONSerialization.ReadingOptions = .allowFragments) {
    self.dataPreprocessor = dataPreprocessor
    self.emptyResponseCodes = emptyResponseCodes
    self.emptyRequestMethods = emptyRequestMethods
    self.options = options
  }
  
  public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> JSON {
    guard error == nil else { throw error! }
    
    guard var data = data, !data.isEmpty else {
      guard emptyResponseAllowed(forRequest: request, response: response) else {
        throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
      }
      
      return JSON(booleanLiteral: false)
    }
    
    data = try dataPreprocessor.preprocess(data)
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: options)
      return JSON(json)
    } catch {
      throw AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
    }
  }
}

extension DataRequest {
  /// Adds a handler to be called once the request has finished.
  ///
  /// - Parameters:
  ///   - queue:             The queue on which the completion handler is dispatched. `.main` by default.
  ///   - options:           The JSON serialization reading options. `.allowFragments` by default.
  ///   - completionHandler: A closure to be executed once the request has finished.
  ///
  /// - Returns:             The request.
  @discardableResult
  public func responseSwiftyJSON(queue: DispatchQueue = .main,
                                 options: JSONSerialization.ReadingOptions = .allowFragments,
                                 completionHandler: @escaping (AFDataResponse<JSON>) -> Void) -> Self {
    return response(queue: queue,
                    responseSerializer: SwiftyJSONResponseSerializer(options: options),
                    completionHandler: completionHandler)
  }
}
