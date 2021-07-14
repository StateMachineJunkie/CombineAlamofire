//
//  AddUserForm.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/31/21.
//

import CombineAlamofire
import Eureka
import UIKit

class AddUserForm: FormViewController {

    private enum FormTag: String {
        case name
        case username
        case email
        case addressStreet
        case addressCity
        case addressZipcode
        case addressSuite
        case locationLat
        case locationLon
        case locationAutofill
        case phone
        case website
        case companyName
        case companyCatchPhrase
        case companyBS
    }

    private var viewModel: ViewModel<JPUser>!

    // MARK: - Initialization
    init(with viewModel: FetchingViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel as? ViewModel<JPUser>
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupForm()
    }

    // MARK: - Target Actions
    @objc func didTapLocationAutofillButton(_ sender: Any) {
        // TODO: Implement location auto-fill functionality.
    }

    @objc func didTapLeftBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @objc func didTapRightBarButton(_ sender: UIBarButtonItem) {
        if validateForm() {
            let newUser = instantiateNewUser(from: form)
            viewModel.addNewElement.send(newUser)
            dismiss(animated: true)
        }
    }

    // MARK: - Private Methods
    private func setupForm() {

        form +++ Section()

            <<< TextRow(FormTag.name.rawValue) {
                $0.title = "Name"
                $0.add(rule: RuleRequired(msg: "A user must have a name."))
            }

            <<< TextRow(FormTag.username.rawValue) {
                $0.title = "Username"
                $0.add(rule: RuleRequired(msg: "A user must have a username."))
            }

            <<< EmailRow(FormTag.email.rawValue) {
                $0.title = "Email Address"
                $0.add(rule: RuleRequired(msg: "A user must have an email address."))
            }

            <<< TextRow(FormTag.phone.rawValue) {
                $0.title = "Phone Number"
            }

            <<< URLRow(FormTag.website.rawValue) {
                $0.title = "Website"
            }

        form +++ Section("Address")

            <<< TextRow(FormTag.addressStreet.rawValue) {
                $0.title = "Street"
            }

            <<< TextRow(FormTag.addressCity.rawValue) {
                $0.title = "City"
            }

            <<< TextRow(FormTag.addressZipcode.rawValue) {
                $0.title = "Zip Code"
            }

            <<< TextRow(FormTag.addressSuite.rawValue) {
                $0.title = "Suite"
            }

        form +++ Section("Geo Location")

            <<< DecimalRow(FormTag.locationLat.rawValue) {
                $0.title = "Latitude"
            }

            <<< DecimalRow(FormTag.locationLon.rawValue) {
                $0.title = "Longitude"
            }

            <<< ButtonRow(FormTag.locationAutofill.rawValue) {
                $0.title = "Autofill Location"
                $0.cell.tintColor = .systemRed
                $0.onCellSelection { (_ /* cell */, row) in
                    self.didTapLocationAutofillButton(row)
                }
            }

        form +++ Section("Company")

            <<< TextRow(FormTag.companyName.rawValue) {
                $0.title = "Name"
            }

            <<< TextRow(FormTag.companyCatchPhrase.rawValue) {
                $0.title = "Catch Phrase"
            }

            <<< TextRow(FormTag.companyBS.rawValue) {
                $0.title = "BS"
            }
    }

    private func setupNavBar() {
        navigationItem.title = NSLocalizedString("Create New User", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapLeftBarButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(didTapRightBarButton(_:)))
    }

    private func validateForm() -> Bool {
        let errorText = NSLocalizedString("Validation Error", comment: "")
        let validationErrors = form.validate()

        guard validationErrors.isEmpty else {
            alertOk(errorText, message: validationErrors.first!.msg)
            return false
        }
        return true
    }

    // swiftlint:disable force_cast
    /// Convert the form contents into a new `JPUser` value.
    ///
    /// There are a lot of implicitly unwrapped optionals in this code. The idea
    /// is that the validation method for this form will make sure that all of
    /// the required fields are present and contain reasonable values. That being
    /// the case, any implicitly unwrapped optionals that lead to a crash are
    /// indications of programming errors on my part. Without some unit/integration/UI
    /// tests to make sure the form works properly, this is still very risky. In
    /// practice, I prefer this type of solution (testing included) to writing
    /// code that is safe (won't detonate) but untested and thus silently fails.
    /// Additionally, testing while including explicitly unwrapped optionals for
    /// cases that should never be `nil` is redundant (IMO). Either the code works
    /// or it doesn't. It is my responsibility to know which is the case and why.
    /// Using explicitly unwrapped optionals instead of testing is not my way of
    /// doing things but as a contractor, I don't always get a choice in the matter.
    /// Especially when inheriting someone else's code.
    ///
    /// All that being said. Because this is an exercise, I may not get around
    /// to adding the tests (which is lazy, sort of). Remember, this project was
    /// originally intended as a self-teaching tool for my personal use to under-
    /// stand how and where to use `Combine` in a `UIKit` project. I expect this
    /// code to evolve as I learn more and make changes.
    ///
    /// - Parameter form: The form containing rows containing input values that
    ///                   should make up a new `JPUser` value.
    /// - Returns: A new `JPUser` value based on form inputs.
    private func instantiateNewUser(from form: Eureka.Form) -> JPUser {
        // General
        let name = (form.rowBy(tag: FormTag.name.rawValue) as! TextRow).value
        let username = (form.rowBy(tag: FormTag.username.rawValue) as! TextRow).value!
        let email = MCEmailAddress(rawValue: (form.rowBy(tag: FormTag.email.rawValue) as! EmailRow).value!)!
        let phone = (form.rowBy(tag: FormTag.phone.rawValue) as! TextRow).value
        let website = (form.rowBy(tag: FormTag.website.rawValue) as! URLRow).value

        // Location
        let location: JPLocation?

        if let latitude = (form.rowBy(tag: FormTag.locationLat.rawValue) as! DecimalRow).value,
           let longitude = (form.rowBy(tag: FormTag.locationLon.rawValue) as! DecimalRow).value {
            location = JPLocation(lat: String(latitude), lng: String(longitude))
        } else {
            location = nil
        }

        // Address
        let address: JPAddress?

        if let city = (form.rowBy(tag: FormTag.addressCity.rawValue) as! TextRow).value,
           let street = (form.rowBy(tag: FormTag.addressStreet.rawValue) as! TextRow).value,
           let zipcode = (form.rowBy(tag: FormTag.addressZipcode.rawValue) as! TextRow).value {
            let suite = (form.rowBy(tag: FormTag.addressSuite.rawValue) as! TextRow).value
            address = JPAddress(street: street, suite: suite, city: city, zipcode: zipcode, geo: location)
        } else {
            address = nil
        }

        // Company
        let company: JPCompany?

        if let companyName = (form.rowBy(tag: FormTag.companyName.rawValue) as! TextRow).value {
            let companyBS = (form.rowBy(tag: FormTag.companyBS.rawValue) as! TextRow).value
            let companyCatchPhrase = (form.rowBy(tag: FormTag.companyCatchPhrase.rawValue) as! TextRow).value
            company = JPCompany(name: companyName,
                                catchPhrase: companyCatchPhrase,
                                bs: companyBS)
        } else {
            company = nil
        }

        return JPUser(username: username,
                      email: email,
                      name: name,
                      address: address,
                      phone: phone,
                      website: website,
                      company: company)
    }
}
