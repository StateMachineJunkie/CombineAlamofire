//
//  Observable.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 7/14/21.
//

import Combine

/// Reusable type can be used to observe *any* model in SwiftUI without requiring subscription logic.
///
/// Implemented using `@dynamicMemberLookup` so that we can access model properties directly.
/// Usage:
/// ```swift
/// @ObservedObject var model: Observable<Model>
///
/// var body: some View {
///     Text(model.property).bold()
/// }
/// ```
/// Taken from: https://www.swiftbysundell.com/tips/building-an-observable-type-for-swiftui-views/
@dynamicMemberLookup final class Observable<Value>: ObservableObject {
    @Published private(set) var value: Value
    private var cancellable: AnyCancellable?

    init<T: Publisher>(value: Value, publisher: T) where T.Output == Value, T.Failure == Never {
        self.value = value
        self.cancellable = publisher.assign(to: \.value, on: self)
    }

    subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}

extension CurrentValueSubject where Failure == Never {
    /// Convenience method to easily convert any subject into an `Observable` object.
    /// - Returns: A new `Observable` wrapper for the given `CurrentValueSubject`.
    /// - Note: Unlike `CurrentValueSubject`, which is mutable, the return type is not mutable.
    ///         Acceptable for use by `Views`.
    func asObservable() -> Observable<Output> {
        Observable(value: value, publisher: self)
    }
}
