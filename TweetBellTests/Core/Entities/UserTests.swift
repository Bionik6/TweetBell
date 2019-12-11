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
    let object: [String:Any] = ["id": 10,
                "name": "Ibrahima Ciss",
                "url": "www.google.com",
                "screen_name": "@bionik6",
                "profile_image_url_https": "www.twitter.com"]
    
    let json = JSON(object)
    let user = User(json: json)
    
    XCTAssertEqual(user.id, 10)
    XCTAssertEqual(user.url, "www.google.com")
    XCTAssertEqual(user.name, "Ibrahima Ciss")
    XCTAssertEqual(user.handle, "@bionik6")
    XCTAssertEqual(user.profileImageUrl, "www.twitter.com")
  }
}
