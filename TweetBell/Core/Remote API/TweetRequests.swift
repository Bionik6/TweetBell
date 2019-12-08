import Foundation
import CoreLocation

enum TweetRequests: Request {
  
  case retweet(tweet: Tweet)
  case search(keywords: String)
  case getTweetsByLocation(location: CLLocation, radius: Int)
  
  var path: String {
    switch self {
      case .search, .getTweetsByLocation: return "search/tweets.json"
      case .retweet(let tweet): return "statuses/retweet/\(tweet.id).json"
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .retweet: return .post
      case .getTweetsByLocation, .search: return .get
    }
  }
  
  var params: RequestParams? {
    switch self {
      case let .getTweetsByLocation(location, radius):
        let (latitude, longitude) = (location.coordinate.latitude,
                                     location.coordinate.longitude)
        return .url([
          "geocode": "\(latitude),\(longitude),\(radius)km",
          "result_type": "recent",
          "count": "100"
        ])
      case .search(let keywords):
        return .url([
          "result_type": "recent",
          "count": "1000",
          "q": keywords
        ])
      case .retweet: return nil
    }
  }
  
  var headers: [String : String]? {
    return ["Authorization": "Bearer \(Secrets.shared.authenticationToken)"]
  }
  
}
