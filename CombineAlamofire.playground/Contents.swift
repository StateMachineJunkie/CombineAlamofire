import Alamofire
import Combine
//import CombineAlamofire
import PlaygroundSupport

// Enable continuous execution
PlaygroundPage.current.needsIndefiniteExecution = true

// Store all subs here until execution completes.
private let subscriptions = Set<AnyCancellable>()

// Create and configure AF session
let evaluators: [String: ServerTrustEvaluating] = ["httpbin.org": DisabledTrustEvaluator()]
//let trustManager = ServerTrustManager(evaluators: evaluators)
//let session = Session(serverTrustManager: trustManager)

//print(session)

//session.request("https://httpbin.org/get").response { response in
//    debugPrint(response)
////    PlaygroundPage.current.finishExecution()
//}

print("Hello")
