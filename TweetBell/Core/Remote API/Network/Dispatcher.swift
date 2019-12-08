import Foundation

protocol Dispatcher: AnyObject {
  
  var session: URLSession { get set }
  var baseURLString: NSString { get set }
  
  init(session: URLSession)
  
  func execute(request: Request, completion: @escaping (Result<JSON, TweetBellError>)->())

}
