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

protocol LocationManager {
  // CLLocationManager Properties
  var location: CLLocation? { get }
  var delegate: CLLocationManagerDelegate? { get set }
  var distanceFilter: CLLocationDistance { get set }
  var desiredAccuracy: CLLocationAccuracy { get set }
  var pausesLocationUpdatesAutomatically: Bool { get set }
  var allowsBackgroundLocationUpdates: Bool { get set }
  
  // CLLocationManager Methods
  func requestAlwaysAuthorization()
  func requestWhenInUseAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
  
  // Wrappers for CLLocationManager class functions
  func isLocationServicesEnabled() -> Bool
  func getAuthorizationStatus() -> CLAuthorizationStatus
}


extension CLLocationManager: LocationManager {
  func isLocationServicesEnabled() -> Bool {
    return CLLocationManager.locationServicesEnabled()
  }
  
  func getAuthorizationStatus() -> CLAuthorizationStatus {
    return CLLocationManager.authorizationStatus()
  }
}


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
//    assert(Thread.isMainThread)
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.startUpdatingLocation()
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.delegate = self
      onComplete(.success(locationManager.location!.coordinate))
      
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
  
  func getCurrentLocation(manager: LocationManager) {
    guard let coordinates = manager.location?.coordinate else { return }
    onComplete(.success(coordinates))
  }
}
