import Foundation

public protocol Request {
  
  var path: String { get }
  var method: HTTPMethod { get }
  var params: RequestParams? { get }
  var headers: [String: String]? { get }
  
}
