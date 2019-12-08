import XCTest
@testable import TweetBell

class ResponseTests: XCTestCase {
  
  var sut: Result<JSON, Error>?
  
  func testSutHasSuccessCase() {
    let jsonDict = ["firstName": "Ibrahima", "lastName": "Ciss"]
    let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
    let jsonObject = try! JSON(data: jsonData)
    let json = JSON(dictionaryLiteral: ("firstName", "Ibrahima"), ("lastName", "Ciss"))
    sut = .success(json)
    if case .success(let successData) = sut! {
      XCTAssertEqual(successData, jsonObject)
    }
  }
  
}
