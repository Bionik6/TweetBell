import Foundation


/// Helper method for creating and configuring an object
/// - Parameters:
///   - object: The object to create
///   - closure: configuration block
func configure<T>(object: T, using closure: (inout T) -> ()) -> T {
  var object = object
  closure(&object)
  return object
}
