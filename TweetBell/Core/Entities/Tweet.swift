import Foundation
import CoreLocation

struct Tweet {
  var id: Int
  var text: String
  var user: User
  var coordinates: String?
  
  init(json: JSON) {
    self.id = json["id"].intValue
    self.text = json["text"].stringValue
    self.user = User(json: json["user"])
  }
}
