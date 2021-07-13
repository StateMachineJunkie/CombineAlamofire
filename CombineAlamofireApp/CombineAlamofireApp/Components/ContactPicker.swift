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
