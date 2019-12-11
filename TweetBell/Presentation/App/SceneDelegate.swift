import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let winScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: winScene)
    let mapViewController = Container.shared.makeMapViewController()
    let navigationController = UINavigationController(rootViewController: mapViewController)
    navigationController.restorationIdentifier = "RootNC"
    self.window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

}
