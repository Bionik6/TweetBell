import Foundation
import CoreLocation

struct Coordinates: Equatable {
  var latitude: Double = 0
  var longitude: Double = 0
  
  init?(json: JSON) {
    guard let geo = json["bounding_box"]["coordinates"][0][0].array else { return nil }
    let values = geo.compactMap { $0.doubleValue }
    self.latitude = values[1]
    self.longitude = values[0]
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
}

struct Tweet {
  var id: Int
  var text: String
  var user: User
  var coordinates: Coordinates?
  
  init(json: JSON) {
    self.id = json["id"].intValue
    self.text = json["text"].stringValue
    self.user = User(json: json["user"])
    self.coordinates = Coordinates(json: json["place"])
  }
}
