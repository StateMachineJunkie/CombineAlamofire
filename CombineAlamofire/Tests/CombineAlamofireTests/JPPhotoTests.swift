//
//  JPPhotoTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
@testable import CombineAlamofire // Without @testable, synthesized initializers are not visible!
import XCTest

final class JPPhotoTests: XCTestCase {

    static let photosJSON = """
        [{
            "id" : 1,
            "albumId" : 1,
            "title" : "accusamus beatae ad facilis cum similique qui sunt",
            "url" : "https://via.placeholder.com/600/92c952",
            "thumbnailUrl" : "https://via.placeholder.com/150/92c952"
        }, {
            "id" : 2,
            "albumId" : 1,
            "title" : "reprehenderit est deserunt velit ipsam",
            "url" : "https://via.placeholder.com/600/771796",
            "thumbnailUrl" : "https://via.placeholder.com/150/771796"
        }]
        """.data(using: .utf8)!

    func testJPPhotoDecode() {
        let decoder = JSONDecoder()
        do {
            let array = try decoder.decode([JPPhoto].self, from: JPPhotoTests.photosJSON)
            XCTAssertEqual(array[0].id.rawValue, 1)
            XCTAssertEqual(array[0].albumId.rawValue, 1)
            XCTAssertEqual(array[0].title, "accusamus beatae ad facilis cum similique qui sunt")
            XCTAssertEqual(array[0].url.absoluteString, "https://via.placeholder.com/600/92c952")
            XCTAssertEqual(array[0].thumbnailUrl.absoluteString, "https://via.placeholder.com/150/92c952")

            XCTAssertEqual(array[1].id.rawValue, 2)
            XCTAssertEqual(array[1].albumId.rawValue, 1)
            XCTAssertEqual(array[1].title, "reprehenderit est deserunt velit ipsam")
            XCTAssertEqual(array[1].url.absoluteString, "https://via.placeholder.com/600/771796")
            XCTAssertEqual(array[1].thumbnailUrl.absoluteString, "https://via.placeholder.com/150/771796")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testJPPhotoEncode() {
        do {
            let photo1 = JPPhoto(id: PhotoId(rawValue: 1)!,
                                 albumId: AlbumId(rawValue: 1)!,
                                 title: "accusamus beatae ad facilis cum similique qui sunt",
                                 url: URL(string: "https://via.placeholder.com/600/92c952")!,
                                 thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!)
            let photo2 = JPPhoto(id: PhotoId(rawValue: 2)!,
                                 albumId: AlbumId(rawValue: 1)!,
                                 title: "reprehenderit est deserunt velit ipsam",
                                 url: URL(string: "https://via.placeholder.com/600/771796")!,
                                 thumbnailUrl: URL(string: "https://via.placeholder.com/150/771796")!)
            let encoder = JSONEncoder()
            let data = try encoder.encode([photo1, photo2])

            let decoder = JSONDecoder()
            let jpPhotos = try decoder.decode([JPPhoto].self, from: data)
            XCTAssertEqual(jpPhotos, [photo1, photo2])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
