import Foundation
struct User {
  var id: Int
  var url: String
  var name: String
  var handle: String
  var profileImageUrl: String
}


extension User {
  init(json: JSON) {
    self.id = json["id"].intValue
    self.name = json["name"].stringValue
    self.url = json["url"].stringValue
    self.handle = json["screen_name"].stringValue
    self.profileImageUrl = json["profile_image_url_https"].stringValue
    
  }
}
