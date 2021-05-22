//
//  EmailAddressTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import CombineAlamofire
import XCTest

class EmailAddressTests: XCTestCase {

    func testEmailAddress() {
        XCTAssertNotNil(MCEmailAddress(rawValue: "statemachinejunkie@gmail.com"))
        XCTAssertNotNil(MCEmailAddress(rawValue: "mc@objc.io"))
        XCTAssertNil(MCEmailAddress(rawValue: ""))
        XCTAssertNil(MCEmailAddress(rawValue: "@"))
        XCTAssertNil(MCEmailAddress(rawValue: "mc@"))
        XCTAssertNil(MCEmailAddress(rawValue: "@objc"))
        XCTAssertNil(MCEmailAddress(rawValue: "@objc.io"))
    }

    static var allTests = [
        ("testEmailAddress", testEmailAddress)
    ]
}
