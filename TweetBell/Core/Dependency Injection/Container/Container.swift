import Foundation

final class Container: NSObject {
  
  static let shared: Container = Container.init()
  
  private override init() {}
  
}

