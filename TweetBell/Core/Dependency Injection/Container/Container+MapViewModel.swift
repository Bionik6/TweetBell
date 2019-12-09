import Foundation
import CoreLocation

extension Container: ViewModelFactory {
  
  func makeMapViewModel() -> MapViewModel {
    let useCase = AskLocationPermissionUseCase()
    return MapViewModel(askPermissionUseCase: useCase)
  }
  
}
