import Foundation
import CoreLocation

extension Container: ViewModelFactory {
  
  func makeMapViewModel() -> MapViewModel {
    let locationManager = CLLocationManager()
    let useCase = AskLocationPermissionUseCase(locationManager: locationManager, onComplete: nil)
    return MapViewModel(askPermissionUseCase: useCase)
  }
  
}
