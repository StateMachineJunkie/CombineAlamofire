//
//  JPCommentTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
@testable import CombineAlamofire // Without @testable, synthesized initializers are not visible!
import XCTest

final class JPCommentTests: XCTestCase {

    static let commentsJSON = """
        [{
            "id" : 1,
            "postId" : 1,
            "name" : "id labore ex et quam laborum",
            "email" : "Eliseo@gardner.biz",
            "body" : "laudantium enim quasi est quidem magnam voluptate ipsam eos\\ntempora quo necessitatibus\\ndolor quam autem quasi\\nreiciendis et nam sapiente accusantium"
        }, {
            "id" : 2,
            "postId" : 1,
            "name" : "quo vero reiciendis velit similique earum",
            "email" : "Jayne_Kuhic@sydney.com",
            "body" : "est natus enim nihil est dolore omnis voluptatem numquam\\net omnis occaecati quod ullam at\\nvoluptatem error expedita pariatur\\nnihil sint nostrum voluptatem reiciendis et"
        }]
        """.data(using: .utf8)!

    func testJPCommentDecode() {
        let decoder = JSONDecoder()
        do {
            let array = try decoder.decode([JPComment].self, from: JPCommentTests.commentsJSON)
            XCTAssertEqual(array[0].id.rawValue, 1)
            XCTAssertEqual(array[0].postId.rawValue, 1)
            XCTAssertEqual(array[0].name, "id labore ex et quam laborum")
            XCTAssertEqual(array[0].email.rawValue, "Eliseo@gardner.biz")
            XCTAssertEqual(array[0].body, "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")

            XCTAssertEqual(array[1].id.rawValue, 2)
            XCTAssertEqual(array[1].postId.rawValue, 1)
            XCTAssertEqual(array[1].name, "quo vero reiciendis velit similique earum")
            XCTAssertEqual(array[1].email.rawValue, "Jayne_Kuhic@sydney.com")
            XCTAssertEqual(array[1].body, "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testJPCommentEncode() {
        do {
            let comment1 = JPComment(id: CommentId(rawValue: 1)!,
                                 	 postId: PostId(rawValue: 1)!,
                                 	 name: "id labore ex et quam laborum",
                                     email: MCEmailAddress(rawValue: "Eliseo@gardner.biz")!,
                                     body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
            let comment2 = JPComment(id: CommentId(rawValue: 2)!,
                                 	 postId: PostId(rawValue: 1)!,
                                 	 name: "quo vero reiciendis velit similique earum",
                                     email: MCEmailAddress(rawValue: "Jayne_Kuhic@sydney.com")!,
                                 	 body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
            let encoder = JSONEncoder()
            let data = try encoder.encode([comment1, comment2])

            let decoder = JSONDecoder()
            let jpComments = try decoder.decode([JPComment].self, from: data)
            XCTAssertEqual(jpComments, [comment1, comment2])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    static var allTests = [
        ("testJPCommentDecode", testJPCommentDecode),
        ("testJPCommentEncode", testJPCommentEncode)
    ]
}
