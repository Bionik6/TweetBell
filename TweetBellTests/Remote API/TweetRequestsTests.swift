import XCTest
import CoreLocation
@testable import TweetBell

class TweetRequestsTests: XCTestCase {
  
  var sut: TweetRequests!
  
  func testTweetsByLocationRequest() {
    let location = CLLocation(latitude: 10, longitude: 20)
    let radius = 5
    sut = .getTweetsByLocation(location: location, radius: radius)
    
    XCTAssertNotNil(sut.headers)
    XCTAssertEqual(sut.method, .get)
    XCTAssertEqual(sut.path, "search/tweets.json")
    
    if let requestParams = sut.params, case .url(let params) = requestParams {
      XCTAssertEqual(params["geocode"] as! String, "10.0,20.0,5km")
      XCTAssertEqual(params["result_type"] as! String, "recent")
      XCTAssertEqual(params["count"] as! String, "100")
    }
  
  }
  
}
