import UIKit

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
  
}
