import Foundation

func configure<T>(object: T, using closure: (inout T) -> ()) -> T {
  var object = object
  closure(&object)
  return object
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
