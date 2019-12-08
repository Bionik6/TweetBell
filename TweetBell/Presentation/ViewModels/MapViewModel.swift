import Combine
import Foundation
import CoreLocation

class MapViewModel: ViewModel, ObservableObject {
  
  @Published var locationPermissionGiven: Bool = false
  @Published var currentLocation: CLLocation? = nil
  
  var onLocationComplete: (AskLocationPermissionUseCaseResult) -> Void = { _ in }
  
  private let askLocationPermissionUseCase: AskLocationPermissionUseCase
  
  init(askPermissionUseCase: AskLocationPermissionUseCase) {
    self.askLocationPermissionUseCase = askPermissionUseCase
  }
  
  func askForLocationPermission() {
    askLocationPermissionUseCase.start()
    askLocationPermissionUseCase.onComplete = { self.onLocationComplete($0) }
    /* askLocationPermissionUseCase.onComplete = { result in
      if case .success(let location) = result { self.currentLocation = location }
      if case .failure = result { self.locationPermissionGiven = false }
    } */
  }
  
}
