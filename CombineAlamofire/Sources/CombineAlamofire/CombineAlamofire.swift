import Alamofire
import Combine
import Foundation

public class CombineAlamofire {

    /// Singleton
    public static let shared = CombineAlamofire()

    // Implementation properties
    private var session: Alamofire.Session!
    private let subscriptions = Set<AnyCancellable>()
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!

    /// Initializer.
    ///
    /// Initialize internal Alamofire session and publishers.
    public init() {
        // For now, we disable cert-pinning but it is a feature we want in the future.
        // Ultimately, we need to disable this for debugging in certain build configurations.
        let evaluators: [String: ServerTrustEvaluating] = [ baseURL.absoluteString : DisabledTrustEvaluator()]
        let serverTrustManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: evaluators)
        let session = Session(startRequestsImmediately: true, serverTrustManager: serverTrustManager)
        self.session = session
    }

    public func getAlbumsPublisher() -> DataResponsePublisher<[JPAlbum]> {
        return session.request(baseURL.appendingPathComponent("albums")).publishDecodable(type: [JPAlbum].self)
    }

    public func getCommentsPublisher() -> DataResponsePublisher<[JPComment]> {
        return session.request(baseURL.appendingPathComponent("comments")).publishDecodable(type: [JPComment].self)
    }

    public func getPostsPublisher() -> DataResponsePublisher<[JPPost]> {
        return session.request(baseURL.appendingPathComponent("posts")).publishDecodable(type: [JPPost].self)
    }

    public func getPhotosPublisher() -> DataResponsePublisher<[JPPhoto]> {
        return session.request(baseURL.appendingPathComponent("photos")).publishDecodable(type: [JPPhoto].self)
    }

    public func getToDosPublisher() -> DataResponsePublisher<[JPToDo]> {
        return session.request(baseURL.appendingPathComponent("todos")).publishDecodable(type: [JPToDo].self)
    }

    public func getUsersPublisher() -> DataResponsePublisher<[JPUser]> {
        return session.request(baseURL).publishDecodable(type: [JPUser].self)
    }
}
