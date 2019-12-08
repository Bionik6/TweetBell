import Foundation


enum TweetRequests: Request {
  case getByLocation(radius: Int)
  case search(keywords: String)
  case retweet(tweet: Tweet)
  
  var path: String
  
  var method: HTTPMethod
  
  var params: RequestParams?
  
  var headers: [String : String]?
  
  
}
