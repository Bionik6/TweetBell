import XCTest
@testable import TweetBell

class CoordinateTests: XCTestCase {
  
  func testInitializer() {
    let coordinates = Coordinates(json: loadJSONFixture(for: "place"))
    
    XCTAssertEqual(coordinates?.longitude, -17.5302485)
    XCTAssertEqual(coordinates?.latitude, 12.3067185)
  }
  
}
