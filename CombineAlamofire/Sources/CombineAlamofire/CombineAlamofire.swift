import Alamofire
import Combine
import UIKit

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

    /// Returns the appropriate `DataResponsePublisher` for the inferred type. If the inferred type is
    /// unsupported, this is a programmer error and crash will occur instead.
    ///
    /// Example:
    /// ```swift
    /// let photos: [JPPhoto] = CombineAlamofire.shared.getPublisher()
    /// ```
    public func getPublisher<Element: Decodable>() -> DataResponsePublisher<[Element]> {
        let type = type(of: Element.self)
        let typeName = "\(type)"
        let path = pathComponents[typeName]!
        return session.request(baseURL.appendingPathComponent(path)).publishDecodable(type: [Element].self)
    }

    /// Fetch photo for URL using async/await.
    ///
    /// This method was added so that I could try out the new async/await functionaltiy for iOS 15. I've updated
    /// the ``ImageLoader`` component to make use of this method for this branch of the source code.
    ///
    /// - Parameter url: Path to photo.
    /// - Returns: `UIImage` if the resource exists and is available. Otherwise and error is thrown.
    @available(iOS 15, *)
    public func fetchPhoto(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
                throw CAError.invalidServerResponse
            }
        guard let image = UIImage(data: data) else {
            throw CAError.unsupportedImageFormat
        }
        return image
    }
}

public enum CAError: Error {
    case invalidServerResponse
    case unsupportedImageFormat
}
