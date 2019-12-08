import UIKit
import Combine

typealias MapUserInterfaceView = MapUserInterface & UIView

final class MapViewController: UIViewController {
  
  private let viewModel: MapViewModel
  private let userInterface: MapUserInterfaceView
  
  init(viewModel: MapViewModel, userInterface: MapUserInterfaceView) {
    self.viewModel = viewModel
    self.userInterface = userInterface
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = userInterface
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupObservers()
  }
  
  private func setupObservers() {
    viewModel.askForLocationPermission()
    viewModel.onLocationComplete = { [weak self] result in
      if case .success(let location) = result {
        self?.userInterface.recenter(at: location)
      }
      if case .failure = result {
        //        self.locationPermissionGiven = false
      }
    }

  }
  
}
