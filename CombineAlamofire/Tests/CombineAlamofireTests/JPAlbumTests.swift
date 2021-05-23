//
//  JPAlbumTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
@testable import CombineAlamofire // Without @testable, synthesized initializers are not visible!
import XCTest

final class JPAlbumTests: XCTestCase {

    static let albumsJSON = """
        [{
            "id" : 1,
            "userId" : 1,
            "title" : "quidem molestiae enim"
        }, {
            "id" : 2,
            "userId" : 1,
            "title" : "sunt qui excepturi placeat culpa"
        }]
        """.data(using: .utf8)!

    func testJPAlbumDecode() {
        let decoder = JSONDecoder()
        do {
            let array = try decoder.decode([JPAlbum].self, from: JPAlbumTests.albumsJSON)
            XCTAssertEqual(array[0].id.rawValue, 1)
            XCTAssertEqual(array[0].userId.rawValue, 1)
            XCTAssertEqual(array[0].title, "quidem molestiae enim")

            XCTAssertEqual(array[1].id.rawValue, 2)
            XCTAssertEqual(array[1].userId.rawValue, 1)
            XCTAssertEqual(array[1].title, "sunt qui excepturi placeat culpa")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testJPAlbumEncode() {
        do {
            let album1 = JPAlbum(id: AlbumId(rawValue: 1)!,
                                 userId: UserId(rawValue: 1)!,
                                 title: "quidem molestiae enim")
            let album2 = JPAlbum(id: AlbumId(rawValue: 2)!,
                                 userId: UserId(rawValue: 1)!,
                                 title: "sunt qui excepturi placeat culpa")
            let encoder = JSONEncoder()
            let data = try encoder.encode([album1, album2])

            let decoder = JSONDecoder()
            let jpPhotos = try decoder.decode([JPAlbum].self, from: data)
            XCTAssertEqual(jpPhotos, [album1, album2])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
