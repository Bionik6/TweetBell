import UIKit
import MapKit
import CoreLocation

final class MapView: UIView, MapUserInterface {
  
  private lazy var mapView = MKMapView()
  
  override func didMoveToWindow() {			
    super.didMoveToWindow()
    setupView()
  }
  
  func setupView() {
    addSubview(mapView)
    mapView.snap(to: self)
  }
  
  func zoomIn() {
    
  }
  
  func zoomOut() {
    
  }
  
  func recenter() {
    
  }
  
  func showPin(at location: CLLocationCoordinate2D) {
    
  }
  
  func showPin() {
    
  }
  
}
