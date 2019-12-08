import XCTest
@testable import TweetBell

class RequestParamsTests: XCTestCase {
  
  var sut: RequestParams?
  
  override func setUp() {
    super.setUp()
    sut = nil
  }
  
  func testSutHasBodyCaseWithADataAssociated() {
    let dict: [String: Any] = ["items": 5, "last": false, "category": "diner"]
    sut = RequestParams.body(dict)
    if case .body(let bodyParams as [String: Any]) = sut! {
      XCTAssertEqual(bodyParams.capacity, dict.capacity)
      XCTAssertEqual(bodyParams["items"] as! Int, dict["items"] as! Int)
      XCTAssertEqual(bodyParams["last"] as! Bool, dict["last"] as! Bool)
      XCTAssertEqual(bodyParams["category"] as! String, dict["category"] as! String)
    }
  }
  
  func testSutHasUrlCaseWithAssociatedData() {
    let dict: [String: Any] = ["items": 5, "last": false, "category": "diner"]
    sut = RequestParams.url(dict)
    if case .url(let urlParams) = sut! {
      XCTAssertEqual(urlParams.capacity, dict.capacity)
      XCTAssertEqual(urlParams["items"] as! Int, dict["items"] as! Int)
      XCTAssertEqual(urlParams["last"] as! Bool, dict["last"] as! Bool)
      XCTAssertEqual(urlParams["category"] as! String, dict["category"] as! String)
    }
  }
  
}
