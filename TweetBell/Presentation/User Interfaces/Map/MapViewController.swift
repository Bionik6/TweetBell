import UIKit
import Combine

typealias MapUserInterfaceView = MapUserInterface & UIView

final class MapViewController: UIViewController {
  
  private var locationSubscriber: AnyCancellable?
  
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
    var fetch = 0
    viewModel.askForLocationPermission()
    locationSubscriber = viewModel.$currentLocation.receive(on: DispatchQueue.main).sink { [weak self] location in
      guard let location = location else { return }
      self?.userInterface.recenter(at: location)
      guard fetch < 2 else { return }
      self?.viewModel.getRecentTweets()
      fetch += 1
    }
    
  }
  
}
