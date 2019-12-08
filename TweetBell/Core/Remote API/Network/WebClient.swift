import Foundation

protocol Dispatcher: AnyObject {
  
  var baseURLString: String { get set }
  var session: URLSession { get set }
  
  init(session: URLSession)
  
  func execute(request: Request, completion: @escaping (Result<JSON, AviaNetworkError>)->())
  func upload(_ file: Data, request: Request, completion: @escaping (Result<JSON, AviaNetworkError>)->())
  
}


final class WebClient: Dispatcher {
  
  var baseURLString: String = "https://amballinone.951e-ax1we-6v16-6n-2012.net:999/"
  
  var session: URLSession
  
  required init(session: URLSession) {
    self.session = session
  }
  
  convenience init(baseURLString: String) {
    self.init(session: URLSession(configuration: .default))
    self.baseURLString = baseURLString
  }
  
  func execute(request: Request, completion: @escaping (Result<JSON, AviaNetworkError>)->()) {
    let reachability = Reachability()
    guard reachability!.isReachable else { completion(.failure(.noInternetConnexion)); return }
    
    let sessionRequest = prepareURLRequest(for: request)
    let task = session.dataTask(with: sessionRequest) { (data, response, error) in
      // Verify we have a valid token First
      guard ((response as? HTTPURLResponse)?.statusCode) != nil else {
        completion(.failure(.internalServerError))
        return
      }
      if (error == nil) {
        guard let data = data, let jsonData = try? JSON(data: data) else {
          completion(.failure(.dataUnprocessable))
          return
        }
        
        if let error = AviaNetworkError(json: jsonData) {
          switch error {
            case .expiredToken, .expiredSession:
              let tokenKeyFetcher = TokenKeyFetcher(client: self, failedRequest: request, completion: completion)
              tokenKeyFetcher.fetchTokenAndExecuteFailedRequest()
            default:
              completion(.failure(error))
              return
          }
        }
        
        completion(.success(jsonData))
      }
      else { completion(.failure(AviaNetworkError.internalServerError)) }
    }
    task.resume()
  }
  
  
  func prepareURLRequest(for request: Request) -> URLRequest {
    
    let fullURLString = baseURLString + request.path
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
    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    urlRequest.httpMethod = request.method.rawValue
    return urlRequest
  }
  
  
  func upload(_ file: Data, request: Request, completion: @escaping (Result<JSON, AviaNetworkError>)->()) {
    
    let fullURLString = baseURLString + request.path
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    var urlRequest = URLRequest(url: url)
    var multipartData = MultipartForm()
    
    if let params = request.params {
      switch params {
        case .body(let bodyParams):
          (bodyParams as? [String: Any])?.forEach { multipartData.append(value: $0.value as? String ?? "", forKey: $0.key) }
        default: break
      }
    }
    
    do {
      multipartData.append(data: file, forKey: "input", fileName: "profile_image.jpeg", mimeType: "image/jpg")
      let data = try multipartData.encode(); urlRequest.httpBody = data
    } catch let e { fatalError(e.localizedDescription) }
    
    if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
    urlRequest.addValue("multipart/form-data; boundary=\(multipartData.boundary)", forHTTPHeaderField: "Content-Type")
    
    urlRequest.httpMethod = request.method.rawValue
    
    session.dataTask(with: urlRequest) { (data, response, error) in
      
      // Verify we have a valid token First
      /* if let status = (response as? HTTPURLResponse)?.statusCode, status == 401 && KeychainPreferences.shared.userToken != nil {
       let invalidTokenInterceptor = InvalidTokenInterceptor(client: self, failedRequest: request, completion: completion)
       invalidTokenInterceptor.executeUpload(file); return
       } */
      
      guard error == nil else { completion(.failure(.dataUnprocessable)); return }
      guard let data = data, let json = try? JSON(data: data) else { completion(.failure(AviaNetworkError.dataUnprocessable)); return }
      completion(.success(json))
    }.resume()
  }
}

