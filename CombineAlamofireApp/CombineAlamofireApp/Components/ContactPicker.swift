//
//  ContactPickerVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 7/12/21.
//

import Combine
import ContactsUI
import UIKit

/// View controller for picking and returning a container of user selected contacts.
///
/// Employed by invoking the `present(from:)` method. When presented, the user
/// can either cancel by swipe gesture or otherwise dismissing the displayed
/// `CNContactUI` view controller.
///
/// This class can be used via the built-in call back attached to the `present(from:completion:)`
/// method but it is actual intended to by used for implementation of the `ContactPickerPublisher`.
public class ContactPicker: NSObject {

    enum Error: Swift.Error {
        case cancelled
        case isPresenting
    }

    private let controller = CNContactPickerViewController()
    private var completion: ((Result<[CNContact], ContactPicker.Error>) -> Void)!
    private var presentingVC: UIViewController?

    var isPresenting: Bool { return completion != nil }

    override init() {
        super.init()
        setupContactPickerVC()
    }

    /// Cancel and dismiss displayed `CNContactUI` view controller.
    func cancel() {
        guard isPresenting else { return }
        // TODO: Verify that this action causes the delegate callback to be invoked!
        presentingVC?.dismiss(animated: true)
    }

    /// Present `CNContactUI` and return the selection results via callback.
    /// - Parameter presentingViewController: Context from which this controller
    func present(from presentingVC: UIViewController, completion: @escaping (Result<[CNContact], ContactPicker.Error>) -> Void) {
        guard isPresenting == false else { completion(.failure(.isPresenting)); return }
        self.completion = completion
        self.presentingVC = presentingVC
        presentingVC.present(controller, animated: true)
    }

    /// Make the `CNContactPickerViewController` instance ready for internal use.
    private func setupContactPickerVC() {
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactImageDataKey,
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey]
        controller.displayedPropertyKeys = keysToFetch
        controller.delegate = self
    }
}


extension ContactPicker: CNContactPickerDelegate {
    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        completion!(Result.failure(.cancelled))
        completion = nil
    }

    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        completion!(Result.success(contacts))
        completion = nil
    }
}

extension ContactPicker {
    func present(from presentingVC: UIViewController) -> Future<[CNContact], ContactPicker.Error> {
        Future { promise in
            self.present(from: presentingVC) { result in
                promise(result)
            }
        }
    }
}

#if false
extension Publishers {
    /// Presents the `CNContactUI` view controller by using the `ContactPicker`
    /// class for implementation. Subscribing to this publisher causes the contact
    /// picker to be displayed. If the user dismisses, the contact picker, this
    /// publisher will complete without returning any output. Otherwise, the user's
    /// selection is returned as output in the form of a `[CNContact]` value.
    /// Once this value is returned, the publishers completes immediately.
    struct ContactPickerPublisher {
        typealias Output = [CNContact]
        typealias Failure = ContactPicker.Error

        let presentingVC: UIViewController

        init(from presentingVC: UIViewController) {
            self.presentingVC = presentingVC
        }

        func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
            let subscription = ContactPickerSubscription(subscriber: subscriber, presentingVC: presentingVC)
            subscriber.receive(subscription: subscription)
        }
    }

    static func contactPicker(from presentingVC: UIViewController) -> Publishers.ContactPickerPublisher {
        return ContactPickerPublisher(from: presentingVC)
    }
}

final class ContactPickerSubscriber: Subscriber {
    typealias Input = [CNContact]
    typealias Failure = ContactPicker.Error

    func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }

    func receive(_ input: [CNContact]) -> Subscribers.Demand {
        // We have what we needed and we're done here.
        return .none
    }

    func receive(completion: Subscribers.Completion<ContactPicker.Error>) {
        NSLog("Received completion: \(completion)")
    }
}

private final class ContactPickerSubscription<S: Subscriber>: Subscription where S.Input == [CNContact], S.Failure == ContactPicker.Error {
    let presentingVC: UIViewController

    var contactPicker: ContactPicker?
    var requested: Subscribers.Demand = .none
    var subscriber: S?

    init(subscriber: S, presentingVC: UIViewController) {
        self.presentingVC = presentingVC
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        requested += demand

        if contactPicker == nil {
            contactPicker = ContactPicker()
            do {
                try contactPicker?.present(from: presentingVC, completion: { [weak self] result in
                    switch result {
                    case let .success(contacts):
                        /* let demand */_ = self?.subscriber?.receive(contacts)
                    case let .failure(error):
                        /* let demand */_ = self?.subscriber?.receive(completion: .failure(error))
                    }
                })
            } catch {
                /* let demand */_ = subscriber?.receive(completion: .failure(ContactPicker.Error.isPresenting))
            }
        } else {
            /* let demand */_ = subscriber?.receive(completion: .finished)
        }
    }

    func cancel() {
        if contactPicker != nil {
            contactPicker?.cancel()
        }
        subscriber = nil
    }
}
#endif
