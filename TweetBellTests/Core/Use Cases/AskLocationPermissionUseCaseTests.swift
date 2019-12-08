import XCTest
import CoreLocation
@testable import TweetBell

struct MockLocationManager: LocationManager {
  var delegate: CLLocationManagerDelegate?
  var distanceFilter: CLLocationDistance = 10
  var allowsBackgroundLocationUpdates: Bool = true
  var pausesLocationUpdatesAutomatically: Bool = false
  var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBestForNavigation
  var location: CLLocation? = CLLocation(latitude: 10, longitude: 10)
  
  func stopUpdatingLocation() { }
  func startUpdatingLocation() { }
  func requestAlwaysAuthorization() { }
  func requestWhenInUseAuthorization() { }
  
  func isLocationServicesEnabled() -> Bool { return true }
  
  func getAuthorizationStatus() -> CLAuthorizationStatus { return .denied }
}


class AskLocationPermissionUseCaseTests: XCTestCase {
  
  private var sut: AskLocationPermissionUseCase!
  
  override func setUp() {
    var locationManager = MockLocationManager()
    sut = AskLocationPermissionUseCase(locationManager: locationManager)
    locationManager.delegate = sut
  }
  
  func testLocationManagerDelegateIsSut() {
    sut.start()
    XCTAssertTrue(sut.locationManager.delegate is AskLocationPermissionUseCase)
  }
  
  func testLocationManagerProperties() {
    XCTAssertEqual(sut.locationManager.distanceFilter, 10)
    XCTAssertEqual(sut.locationManager.allowsBackgroundLocationUpdates, true)
    XCTAssertEqual(sut.locationManager.pausesLocationUpdatesAutomatically, false)
    XCTAssertEqual(sut.locationManager.desiredAccuracy, kCLLocationAccuracyBestForNavigation)
  }
  
  func testLocationServicesEnable() {
    let locationServiceEnabled = sut.locationManager.isLocationServicesEnabled()
    XCTAssertTrue(locationServiceEnabled)
  }
  
  func testCompletion() {
    //    let promise = expectation(description: "on complete expectation")
    //    sut.start()
    sut.onComplete = { result in
      
      switch result {
        //        promise.fulfill()
        case .success(let coordinates):
          XCTAssertEqual(coordinates.latitude, 40)
          XCTAssertEqual(coordinates.longitude, self.sut.locationManager.location!.coordinate.longitude)
        case .failure(let error):
          XCTAssertEqual(error, TweetBellError.locationPermissionNotGiven)
        
      }
    }
    //    waitForExpectations(timeout: 0.5, handler: nil)
  }
  
}
