import XCTest
@testable import TweetBell

class TweetTests: XCTestCase {
  
  func testInitializer() {
    let tweet = Tweet(json: loadJSONFixture(for: "tweet"))
    
    XCTAssertEqual(tweet.id, 1204439183990767616)
    XCTAssertEqual(tweet.text, "Just posted a photo @ Park Nadio https://t.co/kBfLFpw4Na")
    XCTAssertEqual(tweet.user.name, "Khadim Toure")
    XCTAssertEqual(tweet.user.handle, "touresinc")
    XCTAssertEqual(tweet.coordinates, Coordinates(json: loadJSONFixture(for: "place")))
  }
  
}
