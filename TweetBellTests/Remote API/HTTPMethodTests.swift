import XCTest
@testable import TweetBell

class HTTPMethodTests: XCTestCase {
    
    var sut: HTTPMethod?
    
    override func setUp() {
        super.setUp()
    }
    
    func testSutHasGetCase() {
        sut = HTTPMethod.get
        XCTAssertEqual(sut!.rawValue, "GET")
    }
    
    func testSutHasPostCase() {
        sut = HTTPMethod.post
        XCTAssertEqual(sut!.rawValue, "POST")
    }
    
    func testSutHasPutCase() {
        sut = HTTPMethod.put
        XCTAssertEqual(sut!.rawValue, "PUT")
    }
    
    func testSutHasPatchCase() {
        sut = HTTPMethod.patch
        XCTAssertEqual(sut!.rawValue, "PATCH")
    }
    
    func testSutHasDeleteCase() {
        sut = HTTPMethod.delete
        XCTAssertEqual(sut!.rawValue, "DELETE")
    }
    
}
