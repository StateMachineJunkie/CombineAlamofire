//
//  PublisherTests.swift
//  
//
//  Created by Michael A. Crawford on 5/21/21.
//

import Combine
import XCTest
import CombineAlamofire

final class PublisherTests: XCTestCase {
    func testAlbumsPublisher() {
        let expectation = XCTestExpectation(description: "Fetch albums via publisher")
        let publisher = CombineAlamofire.shared.getAlbumsPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testCommentsPublisher() {
        let expectation = XCTestExpectation(description: "Fetch comments via publisher")
        let publisher = CombineAlamofire.shared.getCommentsPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testPhotosPublisher() {
        let expectation = XCTestExpectation(description: "Fetch photos via publisher")
        let publisher = CombineAlamofire.shared.getPhotosPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testPostsPublisher() {
        let expectation = XCTestExpectation(description: "Fetch posts via publisher")
        let publisher = CombineAlamofire.shared.getPostsPublisher()

        var subscriptions = Set<AnyCancellable>()

        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }

    func testToDosPublisher() {
        let expectation = XCTestExpectation(description: "Fetch to-dos via publisher")
        let publisher = CombineAlamofire.shared.getToDosPublisher()

        var subscriptions = Set<AnyCancellable>()
        
        publisher.sink { response in
            XCTAssertNotNil((try? response.result.get()))
            expectation.fulfill()
        }.store(in: &subscriptions)
        wait(for: [expectation], timeout: 10.0)
    }
}
