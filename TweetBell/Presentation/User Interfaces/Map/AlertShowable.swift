import UIKit

protocol AlertShowable {}

extension AlertShowable where Self: UIViewController {
  func showAlert(title: String = "Error", message: String?, completion: (()->())? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
  }
}
