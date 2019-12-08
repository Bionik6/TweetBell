import Foundation

protocol ViewControllerFactory: AnyObject {
  func makeMapViewController() -> MapViewController
}
