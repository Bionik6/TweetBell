import Combine
import Foundation
import CoreLocation

class MapViewModel: ViewModel, ObservableObject {
  
  private var currentLocationSet = false
  @Published var tweets: [Tweet] = [] 
  @Published var currentLocation: CLLocation? = nil
  @Published var locationPermissionGiven: Bool = false
  
  private let askLocationPermissionUseCase: AskLocationPermissionUseCase
  private var showRecentTweetsOnMapUseCase: ShowRecentTweetsOnMapUseCase!
  
  init(askPermissionUseCase: AskLocationPermissionUseCase) {
    self.askLocationPermissionUseCase = askPermissionUseCase
  }
  
  func askForLocationPermission() {
    askLocationPermissionUseCase.start()
    askLocationPermissionUseCase.onComplete = { result in
      if case .success(let location) = result {
        guard self.currentLocationSet == false else { return }
        self.currentLocation = location
        self.currentLocationSet = true
      }
      if case .failure = result { self.locationPermissionGiven = false }
    }
  }
  
  func getRecentTweets() {
    guard let location = currentLocation else { return }
    let request = TweetRequests.getTweetsByLocation(location: location, radius: 5)
    let webClient = WebClient(session: .shared)
    showRecentTweetsOnMapUseCase = ShowRecentTweetsOnMapUseCase(request: request, dispatcher: webClient)
    showRecentTweetsOnMapUseCase.start()
    showRecentTweetsOnMapUseCase.onComplete = { result in
      if case .success(let tweets) = result { self.tweets = tweets.filter { $0.coordinates != nil } }
    }
  }
  
}
