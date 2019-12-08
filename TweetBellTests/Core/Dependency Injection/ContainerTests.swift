import XCTest
@testable import TweetBell

class ContainerTests: XCTestCase {
  
  var sut: Container!
  
  override func setUp() {
    sut = Container.shared
  }
  
  
}
