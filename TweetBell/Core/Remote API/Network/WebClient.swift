import Foundation

final class WebClient: Dispatcher {
  
  var baseURLString: NSString = "https://api.twitter.com/1.1/"
  
  var session: URLSession
  
  required init(session: URLSession) {
    self.session = session
  }
  
  convenience init(baseURLString: NSString) {
    self.init(session: URLSession(configuration: .default))
    self.baseURLString = baseURLString
  }
  
  func execute(request: Request, completion: @escaping (Result<JSON, TweetBellError>)->()) {
    let reachability = Reachability()
    guard reachability!.isReachable else { completion(.failure(.noInternetConnection)); return }
    
    let sessionRequest = prepareURLRequest(for: request)
    let task = session.dataTask(with: sessionRequest) { (data, response, error) in
      
      if (error == nil) {
        guard let data = data, let jsonData = try? JSON(data: data) else { completion(.failure(.dataUnprocessable)); return }
        completion(.success(jsonData))
      }
      else { completion(.failure(.dataUnprocessable)) }
    }
    task.resume()
  }
  
  private func prepareURLRequest(for request: Request) -> URLRequest {
    let fullURLString = baseURLString.appendingPathComponent(request.path)
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    var urlRequest = URLRequest(url: url)
    
    if let params = request.params {
      if case .body(let bodyParams) = params {
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: .init(rawValue: 0))
      }
      if case .url(let urlParams) = params {
        var components = URLComponents(string: fullURLString)!
        components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        urlRequest.url = components.url
      }
    }
    
    if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    urlRequest.httpMethod = request.method.rawValue
    return urlRequest
  }
  
}
