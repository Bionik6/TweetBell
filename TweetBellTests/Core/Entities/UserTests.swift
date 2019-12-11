import XCTest
@testable import TweetBell

class UserTests: XCTestCase {

  func testInitialization() {
    let user = User.init(id: 1,
                         url: "www.google.com",
                         name: "Ibrahima Ciss",
                         handle: "@bionik6",
                         profileImageUrl: "www.twitter.com")
    XCTAssertEqual(user.id, 1)
    XCTAssertEqual(user.url, "www.google.com")
    XCTAssertEqual(user.name, "Ibrahima Ciss")
    XCTAssertEqual(user.handle, "@bionik6")
    XCTAssertEqual(user.profileImageUrl, "www.twitter.com")
  }
  
  func testInitializationWithJSON() {
    let user = User(json: loadJSONFixture(for: "user"))
    
    XCTAssertEqual(user.id, 133152235)
    XCTAssertEqual(user.url, "")
    XCTAssertEqual(user.name, "Khadim Toure")
    XCTAssertEqual(user.handle, "touresinc")
    XCTAssertEqual(user.profileImageUrl, "https://pbs.twimg.com/profile_images/1128064263/Small_normal.png")
  }
}

