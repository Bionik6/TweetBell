import Foundation
import TweetBell

func loadJSONFixture(for file: String) -> JSON {
  let bundle = Bundle.init(for: TweetTests.self)
  guard let url = bundle.url(forResource: file, withExtension: "json"),
    let data = try? Data(contentsOf: url) else {
      fatalError("you must have a \(file).json file in the test bundle")
  }
  return try! JSON(data: data)
}
