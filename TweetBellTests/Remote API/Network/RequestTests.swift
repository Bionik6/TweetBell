import XCTest
@testable import TweetBell


class RequestTests: XCTestCase {

  private var sut: Request?

  class FakeRequest: Request {
    var path: String = "/users"
    var method: HTTPMethod = .get
    var params: RequestParams? = RequestParams.url(["page": 2, "items": 50])
    var headers: [String: String]? = ["Authorization": "Bearer 1234hithere"]
  }

  override func setUp() {
    super.setUp()
    sut = FakeRequest()
  }

  func testSutHasAPath() {
    XCTAssertEqual(sut!.path, "/users")
  }

  func testSutHasHTTPMethod() {
    XCTAssertEqual(sut!.method, HTTPMethod.get)
  }

  func testSutHasHeaders() {
    let headers = ["Authorization": "Bearer 1234hithere"]
    XCTAssertEqual(sut!.headers!, headers)
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

}
