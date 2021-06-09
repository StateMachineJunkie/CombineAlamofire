//
//  JPToDoTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
@testable import CombineAlamofire // Without @testable, synthesized initializers are not visible!
import XCTest

final class JPToDoTests: XCTestCase {

    static let todosJSON = """
        [{
            "id" : 1,
            "userId" : 1,
            "title" : "delectus aut autem",
            "completed" : false 
        }, {
            "id" : 2,
            "userId" : 1,
            "title" : "quis ut nam facilis et officia qui",
            "completed" : false
        }]
        """.data(using: .utf8)!

    func testJPToDoDecode() {
        let decoder = JSONDecoder()
        do {
            let array = try decoder.decode([JPToDo].self, from: JPToDoTests.todosJSON)
            XCTAssertEqual(array[0].id.rawValue, 1)
            XCTAssertEqual(array[0].userId.rawValue, 1)
            XCTAssertEqual(array[0].title, "delectus aut autem")
            XCTAssertEqual(array[0].completed, false)

            XCTAssertEqual(array[1].id.rawValue, 2)
            XCTAssertEqual(array[1].userId.rawValue, 1)
            XCTAssertEqual(array[1].title, "quis ut nam facilis et officia qui")
            XCTAssertEqual(array[1].completed, false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testJPToDoEncode() {
        do {
            let todo1 = JPToDo(id: ToDoId(rawValue: 1)!,
                               userId: UserId(rawValue: 1)!,
                               title: "delectus aut autem",
                               completed: false)
            let todo2 = JPToDo(id: ToDoId(rawValue: 2)!,
                               userId: UserId(rawValue: 1)!,
                               title: "quis ut nam facilis et officia qui",
                               completed: false)
            let encoder = JSONEncoder()
            let data = try encoder.encode([todo1, todo2])

            let decoder = JSONDecoder()
            let jpToDos = try decoder.decode([JPToDo].self, from: data)
            XCTAssertEqual(jpToDos, [todo1, todo2])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    static var allTests = [
        ("testJPToDoDecode", testJPToDoDecode),
        ("testJPToDoEncode", testJPToDoEncode)
    ]
}
