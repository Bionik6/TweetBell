import UIKit

protocol AlertShowable {}

extension AlertShowable where Self: UIViewController {
  
  /// Show a default error alert to the screen
  /// - Parameters:
  ///   - title: Title of the error popup
  ///   - message: Descriptive message about the error
  ///   - completion: Action to perform after the user close the alert
  func showAlert(title: String = "Error", message: String?, completion: (()->())? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
  }
}
