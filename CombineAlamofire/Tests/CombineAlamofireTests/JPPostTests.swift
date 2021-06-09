//
//  JPPostTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
@testable import CombineAlamofire // Without @testable, synthesized initializers are not visible!
import XCTest

final class JPPostTests: XCTestCase {

    static let postsJSON = """
        [{
            "id" : 1,
            "userId" : 1,
            "title" : "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "body" : "quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto"
        }, {
            "id" : 2,
            "userId" : 1,
            "title" : "qui est esse",
            "body" : "est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla"
        }]
        """.data(using: .utf8)!

    func testJPPostDecode() {
        let decoder = JSONDecoder()
        do {
            let array = try decoder.decode([JPPost].self, from: JPPostTests.postsJSON)
            XCTAssertEqual(array[0].id.rawValue, 1)
            XCTAssertEqual(array[0].userId.rawValue, 1)
            XCTAssertEqual(array[0].title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(array[0].body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")

            XCTAssertEqual(array[1].id.rawValue, 2)
            XCTAssertEqual(array[1].userId.rawValue, 1)
            XCTAssertEqual(array[1].title, "qui est esse")
            XCTAssertEqual(array[1].body, "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testJPPostEncode() {
        do {
            let post1 = JPPost(id: PostId(rawValue: 1)!,
                               userId: UserId(rawValue: 1)!,
                               title: "quidem molestiae enim",
                               body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            let post2 = JPPost(id: PostId(rawValue: 2)!,
                               userId: UserId(rawValue: 1)!,
                               title: "sunt qui excepturi placeat culpa",
                               body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
            let encoder = JSONEncoder()
            let data = try encoder.encode([post1, post2])

            let decoder = JSONDecoder()
            let jpPosts = try decoder.decode([JPPost].self, from: data)
            XCTAssertEqual(jpPosts, [post1, post2])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    static var allTests = [
        ("testJPPostDecode", testJPPostDecode),
        ("testJPPostEncode", testJPPostEncode)
    ]
}
