import XCTest
import CoreLocation
@testable import TweetBell

class MockLocationManager: NSObject, LocationManager {
  var delegate: CLLocationManagerDelegate?
  var distanceFilter: CLLocationDistance = 10
  var allowsBackgroundLocationUpdates: Bool = true
  var pausesLocationUpdatesAutomatically: Bool = false
  var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBestForNavigation
  var location: CLLocation? = CLLocation(latitude: 10, longitude: 10)
  
  func requestLocation() {}
  func stopUpdatingLocation() {}
  func startUpdatingLocation() {}
  func requestAlwaysAuthorization() {}
  func requestWhenInUseAuthorization() {}
  
  func isLocationServicesEnabled() -> Bool { return true }
  
  func getAuthorizationStatus() -> CLAuthorizationStatus { return .authorizedAlways }
}

extension MockLocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.locationManager(manager, didUpdateLocations: locations)
  }
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    
  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
  }
}


class AskLocationPermissionUseCaseTests: XCTestCase {
  
  private var sut: AskLocationPermissionUseCase!
  
  override func setUp() {
    let locationManager = MockLocationManager()
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
  
  func testCurrentLocation() {
    sut.locationManager.requestLocation()
    XCTAssertEqual(sut.locationManager.location!.coordinate.longitude, 10)
    XCTAssertEqual(sut.locationManager.location!.coordinate.latitude, 10)
  }
  
}
