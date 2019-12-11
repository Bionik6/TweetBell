import XCTest
@testable import TweetBell

class TestLogger: Logger {
  
  var debugCalled: Bool = false
  var errorCalled: Bool = false
  
  override func debug(_ message: Any, file: String = #file, line: Int = #line) {
    debugCalled = true
    super.debug(message)
  }
  
  override func error(_ message: Any, file: String = #file, line: Int = #line) {
    errorCalled = true
    super.error(message)
  }

}


class LoggerTests: XCTestCase {
  
  private var sut: TestLogger!
  
  override func setUp() {
    sut = TestLogger()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testDebugMethod() {
    XCTAssertFalse(sut.debugCalled)
    sut.debug("Hello World")
    XCTAssertTrue(sut.debugCalled)
  }
  
  func testErrorMethod() {
    XCTAssertFalse(sut.errorCalled)
    sut.error("Nasty Error")
    XCTAssertTrue(sut.errorCalled)
  }

  
}
