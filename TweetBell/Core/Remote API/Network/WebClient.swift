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
  
  func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, TweetBellError>)->()) {
    let reachability = Reachability()
    guard reachability!.isReachable else { completion(.failure(.noInternetConnection)); return }
    
    let sessionRequest = prepareURLRequest(for: request)
    let task = session.dataTask(with: sessionRequest) { (data, response, error) in
      
      guard ((response as? HTTPURLResponse)?.statusCode) != nil else {
        completion(.failure(.dataUnprocessable))
        return
      }
      if (error == nil) {
        guard let data = data else { completion(.failure(.dataUnprocessable)); return }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let newData = try! decoder.decode(T.self, from: data)
        completion(.success(newData))
      }
      else { completion(.failure(.dataUnprocessable)) }
    }
    task.resume()
  }
  
  
  func prepareURLRequest(for request: Request) -> URLRequest {
    let fullURLString = baseURLString.appendingPathComponent(request.path)
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    var urlRequest = URLRequest(url: url)
    
    if let params = request.params {
      switch params {
        case .body(let bodyParams):
          urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: .init(rawValue: 0))
        case .url(let urlParams):
          var components = URLComponents(string: fullURLString)!
          components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
      }
    }
    
    if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    urlRequest.httpMethod = request.method.rawValue
    return urlRequest
  }
  
}
