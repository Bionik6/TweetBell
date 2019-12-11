import Foundation

typealias ShowRecentTweetsOnMapUseCaseResult = Result<[Tweet], TweetBellError>

final class ShowRecentTweetsOnMapUseCase: UseCase {
  
  private let request: Request
  private let dispatcher: Dispatcher
  var onComplete: (ShowRecentTweetsOnMapUseCaseResult) -> Void = { _ in }
  
  init(request: Request, dispatcher: Dispatcher) {
    self.request = request
    self.dispatcher = dispatcher
  }
  
  /// Default method to go fetch the last tweets
  func start() {
    dispatcher.execute(request: request) { response in
      switch response {
        case .success(let json):
          let tweets = json["statuses"].arrayValue.compactMap { Tweet.init(json: $0) }
          self.onComplete(.success(tweets))
        case .failure(_): break
      }
    }
  }
  
}
