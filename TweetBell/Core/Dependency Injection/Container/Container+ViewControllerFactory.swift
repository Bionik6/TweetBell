import CoreLocation
import Foundation

extension Container: ViewControllerFactory {
  
  func makeMapViewController() -> MapViewController {
    let viewModel = makeMapViewModel()
    let userInterface = MapView()
    return MapViewController(viewModel: viewModel, userInterface: userInterface)
  }
  
}
