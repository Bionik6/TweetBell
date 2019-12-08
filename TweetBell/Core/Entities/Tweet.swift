import Foundation
import CoreLocation

struct Tweet {
  var id: Int
  var text: String
//  var date: Date
  var user: User
  var coordinates: String?
  
  
  var location: CLLocationCoordinate2D? {
    return nil
  }
  
  
  init(json: JSON) {
    self.id = json["id"].intValue
    self.text = json["text"].stringValue
//    self.date = DateFormatter().date(from: json["created_at"].stringValue)
    self.user = User(json: json["user"])
    if let coordinates = json["geo"]["coordinates"].array {
      // self.coordinates =
      log.debug(coordinates)
    }
 
  }
}
