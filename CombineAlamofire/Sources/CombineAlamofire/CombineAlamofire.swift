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
    private let pathComponents: [String: String] = [
        "JPAlbum.Type": "albums",
        "JPComment.Type": "comments",
        "JPPost.Type": "posts",
        "JPPhoto.Type": "photos",
        "JPToDo.Type": "todos",
        "JPUser.Type": "users"
    ]

    /// Initializer.
    ///
    /// Initialize internal Alamofire session and publishers.
    public init() {
        // For now, we disable cert-pinning but it is a feature we want in the future.
        // Ultimately, we need cert-pinning to be enabled and disabled based on
        // the build configuration being used. This will provide the added security
        // we want while not hindering the debugging process.
        let evaluators: [String: ServerTrustEvaluating] = [baseURL.host! : DisabledTrustEvaluator()]
        let serverTrustManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: evaluators)
        // We also disable caching while developing our solution.
        let cacher = ResponseCacher(behavior: .doNotCache)
        let session = Session(startRequestsImmediately: true, serverTrustManager: serverTrustManager, cachedResponseHandler: cacher)
        self.session = session
    }

    public func getPublisher<Element: Decodable>() -> DataResponsePublisher<[Element]> {
        let type = type(of: Element.self)
        let typeName = "\(type)"
        let path = pathComponents[typeName]!
        return session.request(baseURL.appendingPathComponent(path)).publishDecodable(type: [Element].self)
    }
}
