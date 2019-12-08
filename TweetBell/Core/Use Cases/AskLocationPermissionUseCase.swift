import Foundation
import CoreLocation

enum TweetBellError: LocalizedError {
  case noInternetConnection
  case dataUnprocessable
  case locationPermissionNotGiven
  
  var errorDescription: String? {
    return nil
  }
  
  var failureReason: String? {
    return nil
  }
}

typealias AskLocationPermissionUseCaseResult = Result<CLLocationCoordinate2D, TweetBellError>

class AskLocationPermissionUseCase: NSObject, UseCase {
  
  var onComplete: (AskLocationPermissionUseCaseResult) -> Void
  private let locationManager: CLLocationManager
  
  init(locationManager: CLLocationManager,
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


extension AskLocationPermissionUseCase: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    getCurrentLocation(manager: manager)
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
  
  func getCurrentLocation(manager: CLLocationManager) {
    guard let coordinates = manager.location?.coordinate else { return }
    onComplete(.success(coordinates))
  }
}
