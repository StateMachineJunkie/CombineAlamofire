//
//  JPUserTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
@testable import CombineAlamofire // Without @testable, synthesized initializers are not visible!
import XCTest

final class JPUserTests: XCTestCase {

    static let usersJSON = """
        [{
            "id" : 1,
            "name" : "Leanne Graham",
            "username" : "Bret",
            "email" : "Sincere@april.biz",
            "address" : {
                "street" : "Kulas Light",
                "suite" : "Apt. 556",
                "city" : "Gwenborough",
                "zipcode" : "92998-3874",
                "geo" : {
                    "lat" : "-37.3159",
                    "lng" : "81.1496"
                }
            },
            "phone" : "1-770-736-8031 x56442",
            "website" : "hildegard.org",
            "company" : {
                "name" : "Romaguera-Crona",
                "catchPhrase" : "Multi-layered client-server neural-net",
                "bs" : "harness real-time e-markets"
            }
        }, {
            "id" : 2,
            "name" : "Ervin Howell",
            "username" : "Antonette",
            "email" : "Shanna@melissa.tv",
            "address" : {
                "street" : "Victor Plains",
                "suite" : "Suite 879",
                "city" : "Wisokyburgh",
                "zipcode" : "90566-7771",
                "geo" : {
                    "lat" : "-43.9509",
                    "lng" : "-34.4618"
                }
            },
            "phone" : "010-692-6593 x09125",
            "website" : "anastasia.net",
            "company" : {
                "name" : "Deckow-Crist",
                "catchPhrase" : "Proactive didactic contingency",
                "bs" : "synergize scalable supply-chains"
            }
        }]
        """.data(using: .utf8)!

    func testJPUserDecode() {
        let decoder = JSONDecoder()
        do {
            let array = try decoder.decode([JPUser].self, from: JPUserTests.usersJSON)
            XCTAssertEqual(array[0].id.rawValue, 1)
            XCTAssertEqual(array[0].name, "Leanne Graham")
            XCTAssertEqual(array[0].username, "Bret")
            XCTAssertEqual(array[0].email.rawValue, "Sincere@april.biz")
            XCTAssertEqual(array[0].address.street, "Kulas Light")
            XCTAssertEqual(array[0].address.suite, "Apt. 556")
            XCTAssertEqual(array[0].address.city, "Gwenborough")
            XCTAssertEqual(array[0].address.zipcode, "92998-3874")
            XCTAssertEqual(array[0].address.geo.lat, "-37.3159")
            XCTAssertEqual(array[0].address.geo.lng, "81.1496")
            XCTAssertEqual(array[0].phone, "1-770-736-8031 x56442")
            XCTAssertEqual(array[0].website.absoluteString, "hildegard.org")
            XCTAssertEqual(array[0].company.name, "Romaguera-Crona")
            XCTAssertEqual(array[0].company.catchPhrase, "Multi-layered client-server neural-net")
            XCTAssertEqual(array[0].company.bs, "harness real-time e-markets")

            XCTAssertEqual(array[1].id.rawValue, 2)
            XCTAssertEqual(array[1].name, "Ervin Howell")
            XCTAssertEqual(array[1].username, "Antonette")
            XCTAssertEqual(array[1].email.rawValue, "Shanna@melissa.tv")
            XCTAssertEqual(array[1].address.street, "Victor Plains")
            XCTAssertEqual(array[1].address.suite, "Suite 879")
            XCTAssertEqual(array[1].address.city, "Wisokyburgh")
            XCTAssertEqual(array[1].address.zipcode, "90566-7771")
            XCTAssertEqual(array[1].address.geo.lat, "-43.9509")
            XCTAssertEqual(array[1].address.geo.lng, "-34.4618")
            XCTAssertEqual(array[1].phone, "010-692-6593 x09125")
            XCTAssertEqual(array[1].website.absoluteString, "anastasia.net")
            XCTAssertEqual(array[1].company.name, "Deckow-Crist")
            XCTAssertEqual(array[1].company.catchPhrase, "Proactive didactic contingency")
            XCTAssertEqual(array[1].company.bs, "synergize scalable supply-chains")
        } catch {
            if let decodingError = error as? DecodingError {
                XCTFail(decodingError.localizedDescription)
            } else {
            XCTFail(error.localizedDescription)
            }
        }
    }

    func testJPUserEncode() {
        do {
            var location = JPLocation(lat: "-37.3159", lng: "81.1496")
            var address = JPAddress(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: location)
            var company = JPCompany(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
            let user1 = JPUser(id: UserId(rawValue: 1)!,
                               name: "Leanne Graham",
                               username: "Bret",
                               email: MCEmailAddress(rawValue: "Sincere@april.biz")!,
                               address: address,
                               phone: "1-770-736-8031 x56442",
                               website: URL(string: "hildegard.org")!,
                               company: company)
            location = JPLocation(lat: "-43.9509", lng: "-34.4618")
            address = JPAddress(street: "Victor Plains", suite: "Suite 879", city: "Wisokyburgh", zipcode: "90566-7771", geo: location)
            company = JPCompany(name: "Deckow-Crist", catchPhrase: "Proactive didactic contingency", bs: "synergize scalable supply-chains")
            let user2 = JPUser(id: UserId(rawValue: 2)!,
                               name: "Ervin Howell",
                               username: "Antonette",
                               email: MCEmailAddress(rawValue: "Shanna@melissa.tv")!,
                               address: address,
                               phone: "010-692-6593 x09125",
                               website: URL(string: "anastasia.net")!,
                               company: company)
            let encoder = JSONEncoder()
            let data = try encoder.encode([user1, user2])

            let decoder = JSONDecoder()
            let jpUsers = try decoder.decode([JPUser].self, from: data)
            XCTAssertEqual(jpUsers, [user1, user2])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    static var allTests = [
        ("testJPUserDecode", testJPUserDecode),
        ("testJPUserEncode", testJPUserEncode)
    ]
}
