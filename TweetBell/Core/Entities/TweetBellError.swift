import Foundation

enum TweetBellError: LocalizedError {
  case noInternetConnection
  case dataUnprocessable
  case locationPermissionNotGiven
  
  var errorDescription: String? {
    return nil
  }
  
  var failureReason: String? {
    return nil
  }
}
