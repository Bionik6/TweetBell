import Foundation.NSBundle

struct Secrets: Decodable {
  
  let apiKey: String
  let apiSecretKey: String
  let accessToken: String
  let accessTokenSecret: String
  let authenticationToken: String
  
  static let shared = Secrets()
  
  private init() {
    guard let url = Bundle.main.url(forResource: "secrets", withExtension: "json"),
      let data = try? Data(contentsOf: url) else {
        fatalError("you must have a secrets.json file in the main bundle and add your credentials")
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    self = try! decoder.decode(Secrets.self, from: data)
  }
  
  
}
