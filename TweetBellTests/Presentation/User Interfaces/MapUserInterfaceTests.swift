import XCTest
import CoreLocation
@testable import TweetBell


class MapUserInterfaceTests: XCTestCase {
  
  final class MapIntervaceMock: MapUserInterface {
    func setupView() {
      
    }
    
    func recenter(at location: CLLocation) {
      
    }
    
    func showTweetsOnMap(tweets: [Tweet]) {
      
    }
  }
  
  private var sut: MapUserInterface!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
}
