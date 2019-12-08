import UIKit
import MapKit
import CoreLocation

final class MapView: UIView, MapUserInterface {
  
  private lazy var mapView = configure(object: MKMapView()) {
    $0.showsScale = true
    $0.showsCompass = true
    $0.isPitchEnabled = true
    $0.isRotateEnabled = true
    $0.showsUserLocation = true
  }
  
  override func didMoveToWindow() {			
    super.didMoveToWindow()
    setupView()
  }
  
  func setupView() {
    addSubview(mapView)
    mapView.snap(to: self)
  }
  
  func recenter(at location: CLLocation) {
    let regionRadius: CLLocationDistance = 3000
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
}
