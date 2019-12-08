import struct CoreLocation.CLLocationCoordinate2D

protocol MapUserInterface: AnyObject {
  func zoomIn()
  func zoomOut()
  func recenter()
  func showPin(at location: CLLocationCoordinate2D)
}
