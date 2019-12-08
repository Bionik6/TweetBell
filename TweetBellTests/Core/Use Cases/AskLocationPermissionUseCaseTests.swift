import XCTest
import CoreLocation
@testable import TweetBell


class AskLocationPermissionUseCaseTests: XCTestCase {
  
  private var sut: AskLocationPermissionUseCase!
  private let locationManager = CLLocationManager()
  
  override func setUp() {
    sut = AskLocationPermissionUseCase(locationManager: locationManager)
  }
  
  func testLocationManagerDelegateIsSut() {
    sut.start()
    assert(locationManager.delegate is AskLocationPermissionUseCase)
  }
  
  func teststart() {
    let promise = expectation(description: "location permission")
    sut.start()
    sut.onComplete = { result in
    promise.fulfill()
      
    }    
    wait(for: [promise], timeout: 2)
  }
}
