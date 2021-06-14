//
//  PublisherTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Alamofire
import Combine
import CombineAlamofire
import XCTest

final class PublisherTests: XCTestCase {

    func testAlbumsPublisher() {
        let expectation = XCTestExpectation(description: "Fetch albums via publisher")
        let publisher: DataResponsePublisher<[JPAlbum]> = CombineAlamofire.shared.getPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testCommentsPublisher() {
        let expectation = XCTestExpectation(description: "Fetch comments via publisher")
        let publisher: DataResponsePublisher<[JPComment]> = CombineAlamofire.shared.getPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testPhotosPublisher() {
        let expectation = XCTestExpectation(description: "Fetch photos via publisher")
        let publisher: DataResponsePublisher<[JPPhoto]> = CombineAlamofire.shared.getPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testPostsPublisher() {
        let expectation = XCTestExpectation(description: "Fetch posts via publisher")
        let publisher: DataResponsePublisher<[JPPost]> = CombineAlamofire.shared.getPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testToDosPublisher() {
        let expectation = XCTestExpectation(description: "Fetch to-dos via publisher")
        let publisher: DataResponsePublisher<[JPToDo]> = CombineAlamofire.shared.getPublisher()

        var subscriptions = Set<AnyCancellable>()
        
        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testUsersPublisher() {
        let expectation = XCTestExpectation(description: "Fetch user via publisher")
        let publisher: DataResponsePublisher<[JPUser]> = CombineAlamofire.shared.getPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    static var allTests = [
        ("testAlbumsPublisher", testAlbumsPublisher),
        ("testCommentsPublisher", testCommentsPublisher),
        ("testPhotosPublisher", testPhotosPublisher),
        ("testPostsPublisher", testPostsPublisher),
        ("testToDosPublisher", testToDosPublisher),
        ("testUsersPublisher", testUsersPublisher)
    ]
}
