import Foundation

protocol Dispatcher: AnyObject {
  
  var session: URLSession { get set }
  var baseURLString: NSString { get set }
  
  init(session: URLSession)
  
  func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, TweetBellError>)->())

}
