import Foundation

func configure<T>(object: T, using closure: (inout T) -> ()) -> T {
  var object = object
  closure(&object)
  return object
}
