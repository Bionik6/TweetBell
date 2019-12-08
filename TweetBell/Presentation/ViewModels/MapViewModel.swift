import Combine
import Foundation
import CoreLocation

class MapViewModel: ViewModel, ObservableObject {
  
  @Published var locationPermissionGiven: Bool = false
  @Published var currentCoordinates: CLLocationCoordinate2D? = nil

  private let askLocationPermissionUseCase: AskLocationPermissionUseCase
  
  init(askPermissionUseCase: AskLocationPermissionUseCase) {
    self.askLocationPermissionUseCase = askPermissionUseCase
  }
  
  func askForLocationPermission() {
    askLocationPermissionUseCase.start()
    askLocationPermissionUseCase.onComplete = { result in
      if case .success(let coordinates) = result { self.currentCoordinates = coordinates }
      if case .failure = result { self.locationPermissionGiven = false }
    }
  }
  
}
