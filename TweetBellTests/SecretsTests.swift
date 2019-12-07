@testable import TweetBell
import XCTest

class SecretsTests: XCTestCase {
  
  var sut: Secrets!
  
  override func setUp() {
    sut = Secrets.shared
  }
  
  func testApiKeyIsSet() {
    let apiKey = sut.apiKey
    XCTAssertTrue(apiKey.isEmpty == false, "The API KEY is not set")
  }
  
  func testApiSecretKeyIsSet() {
    let apiSecretKey = sut.apiSecretKey
    XCTAssertTrue(apiSecretKey.isEmpty == false, "The API Secret Key is not set")
  }
  
  func testAccessTokenIsSet() {
    let accessToken = sut.accessToken
    XCTAssertTrue(accessToken.isEmpty == false, "The ACCESS TOKEN is not set")
  }
  
  func testAccessTokenSecretIsSet() {
    let accessTokenSecret = sut.accessTokenSecret
    XCTAssertTrue(accessTokenSecret.isEmpty == false, "The ACCESS TOKEN SECRET is not set")
  }
  
}
