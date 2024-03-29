import UIKit
import Combine

typealias MapUserInterfaceView = MapUserInterface & UIView

final class MapViewController: UIViewController, AlertShowable {
  
  private let viewModel: MapViewModel
  private let userInterface: MapUserInterfaceView
  private var subscriptions = Set<AnyCancellable>()
  
  init(viewModel: MapViewModel, userInterface: MapUserInterfaceView) {
    self.viewModel = viewModel
    self.userInterface = userInterface
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  override func loadView() { view = userInterface }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.askForLocationPermission()
    setupObservers()
  }
  
  /// Wire observers to userinterface so the view can react when a publisher emits a signal
  private func setupObservers() {
    viewModel.$currentLocation.receive(on: DispatchQueue.main).sink { [weak self] location in
      guard let location = location else { return }
      self?.userInterface.recenter(at: location)
      self?.viewModel.getRecentTweets()
    }.store(in: &subscriptions)
    
    viewModel.$tweets.receive(on: DispatchQueue.main).sink { [weak self] tweets in
      self?.userInterface.showTweetsOnMap(tweets: tweets)
    }.store(in: &subscriptions)
    
    viewModel.$locationPermissionGiven.receive(on: DispatchQueue.main).sink { [weak self] permission in
      guard permission == false else { return }
      self?.showAlert(message: "Please verify your internet and make sure you give location permission")
    }.store(in: &subscriptions)
  }
}
