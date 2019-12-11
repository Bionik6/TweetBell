import XCTest
import CoreLocation
@testable import TweetBell

class MockURLSession: URLSession {
  override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return MockURLSessionDataTask(completionHandler: completionHandler, url: url)
  }
}


class MockURLSessionDataTask: URLSessionDataTask {
  var url: URL
  var completionHandler: (Data?, URLResponse?, Error?) -> Void
  
  init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, url: URL) {
    self.completionHandler = completionHandler
    self.url = url
  }
  
  override func resume() { }
}


class ShowRecentTweetsOnMapUseCaseTests: XCTestCase {
  
  private var sut: ShowRecentTweetsOnMapUseCase!
  
  override func setUp() {
    let location = CLLocation(latitude: 10, longitude: 10)
    let request = TweetRequests.getTweetsByLocation(location: location, radius: 5)
    let dispatcher = WebClient(session: MockURLSession.shared)
    sut = ShowRecentTweetsOnMapUseCase(request: request, dispatcher: dispatcher)
  }
  
  func testStartMethod() {
    let promise = expectation(description: "start expectation")
    sut.start()
    sut.onComplete = { result in
      switch result {
        case .success(let tweets):
          XCTAssertEqual(tweets.count, 0)
        case .failure(let error):
          XCTAssertEqual(error, TweetBellError.locationPermissionNotGiven)
      }
      promise.fulfill()
    }
    waitForExpectations(timeout: 1)
  }
  
}
