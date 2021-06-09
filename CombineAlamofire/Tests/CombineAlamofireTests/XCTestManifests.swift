import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EmailAddressTests.allTests),
        testCase(JPAlbumTests.allTests),
        testCase(JPCommentTests.allTests),
        testCase(JPPhotoTests.allTests),
        testCase(JPPostTests.allTests),
        testCase(JPToDoTests.allTests),
        testCase(JPUserTests.allTests),
        testCase(PublisherTests.allTests)
    ]
}
#endif
