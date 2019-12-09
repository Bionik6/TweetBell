import Foundation
import CoreLocation

struct Coordinates {
  var latitude: Double = 0
  var longitude: Double = 0
  
  init?(json: JSON) {
    guard let geo = json["coordinates"].array else { return nil }
    let values = geo.compactMap { $0.doubleValue }
    self.latitude = values[0]
    self.longitude = values[1]
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
    self.coordinates = Coordinates(json: json["geo"])
  }
}
