import CoreLocation

protocol LocationManager {
  // CLLocationManager Properties
  var location: CLLocation? { get }
  var distanceFilter: CLLocationDistance { get set }
  var desiredAccuracy: CLLocationAccuracy { get set }
  var delegate: CLLocationManagerDelegate? { get set }
  var allowsBackgroundLocationUpdates: Bool { get set }
  var pausesLocationUpdatesAutomatically: Bool { get set }
  
  // CLLocationManager Methods
  func requestLocation()
  func stopUpdatingLocation()
  func startUpdatingLocation()
  func requestAlwaysAuthorization()
  func requestWhenInUseAuthorization()
  
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
