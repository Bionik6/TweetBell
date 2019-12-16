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
  
  
  /// Position tweets on map
  /// - Parameter tweets: [Tweet] to be position
  func showTweetsOnMap(tweets: [Tweet]) {
    tweets.forEach {
      guard let coordinates = $0.coordinates else { return }
      let annotation = MKPointAnnotation()
      annotation.title = $0.user.name
      annotation.subtitle = $0.text
      annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude,
                                                     longitude: coordinates.longitude)
      self.mapView.removeAnnotation(annotation)
      self.mapView.addAnnotation(annotation)
    }
  }
  
}
