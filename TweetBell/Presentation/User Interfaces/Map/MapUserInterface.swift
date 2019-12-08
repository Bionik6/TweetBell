import CoreLocation.CLLocation

protocol MapUserInterface: AnyObject {
  func setupView()
  func recenter(at location: CLLocation)
}
