import Foundation
import CoreLocation

typealias AskLocationPermissionUseCaseResult = Result<CLLocation, TweetBellError>

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
      locationManager.delegate = self
      locationManager.startUpdatingLocation()
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    } else {
      onComplete(.failure(.locationPermissionNotGiven))
    }
  }
  
}

// MARK: - CLLocationManagerDelegate
extension AskLocationPermissionUseCase: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = manager.location else { return }
    onComplete(.success(location))
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
