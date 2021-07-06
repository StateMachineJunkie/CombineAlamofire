//
//  ContactPicker.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael Crawford on 7/5/21.
//  Copyright © 2021 CDE, LLC. All rights reserved.
//

import ContactsUI
import SwiftUI

struct ContactPicker: UIViewControllerRepresentable {
    // Due to some sort of Apple defect, we can't present the Contacts UI directly.
    // Instead, we wrap it in a UINavigationController, which seems to work.
    // Perhaps it just needs to be wrapped by a UINavigationController directly
    // and the Navigation View from the SwiftUI parent isn't good enough but that's
    // just a WAG.
    typealias UIViewControllerType = UINavigationController

    class Coordinator: NSObject, CNContactPickerDelegate, UINavigationControllerDelegate {
        var parent: ContactPicker

        init(_ parent: ContactPicker) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
//            parent.contacts = [contact]
            parent.presentationMode.wrappedValue.dismiss()
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
//            parent.contacts = contacts
            parent.presentationMode.wrappedValue.dismiss()
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelectContactProperties contactProperties: [CNContactProperty]) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Binding var contact: CNContact?
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let navController = UINavigationController()
        let picker = CNContactPickerViewController()
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactImageDataKey,
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey
        ]
        picker.displayedPropertyKeys = keysToFetch
        picker.delegate = context.coordinator
        navController.present(picker, animated: false)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Empty
    }
}
