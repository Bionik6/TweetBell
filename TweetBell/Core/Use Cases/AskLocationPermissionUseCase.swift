import Foundation
import CoreLocation

typealias AskLocationPermissionUseCaseResult = Result<CLLocationCoordinate2D, TweetBellError>

class AskLocationPermissionUseCase: NSObject, UseCase {
  
  var onComplete: (AskLocationPermissionUseCaseResult) -> Void
  private(set) var locationManager: LocationManager
  
  init(locationManager: LocationManager,
       onComplete: ((AskLocationPermissionUseCaseResult) -> Void)? = nil) {
    self.locationManager = locationManager
    self.onComplete = onComplete ?? { result in }
  }
  
  func start() {
    assert(Thread.isMainThread)
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.startUpdatingLocation()
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.delegate = self
    } else {
      onComplete(.failure(.locationPermissionNotGiven))
    }
  }
  
}

// MARK: - CLLocationManagerDelegate
extension AskLocationPermissionUseCase: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    getCurrentLocation(manager: manager)
    guard let coordinates = manager.location?.coordinate else { return }
    onComplete(.success(coordinates))
  }
  
  // Handle authorization
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
      case .authorizedWhenInUse, .authorizedAlways:
        getCurrentLocation(manager: locationManager)
      case .denied:
        onComplete(.failure(.locationPermissionNotGiven))
      default: break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    onComplete(.failure(.locationPermissionNotGiven))
  }
  
  func getCurrentLocation(manager: LocationManager) {
    manager.requestLocation()
    manager.requestWhenInUseAuthorization()
  }
}
