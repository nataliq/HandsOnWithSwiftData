import XCTest
@testable import HandsOnWithSwiftData
import SwiftData

final class HandsOnWithSwiftDataTests: XCTestCase {

    @MainActor
    func testModelCreation() throws {
        let tagNames = (1...10).map(String.init)
        let tags = tagNames.map {
            Tag(name: $0)
        }

        let thought = Thought(text: "test", tags: tags)
        XCTAssertEqual(thought.tags.map { $0.name }, tagNames)
    }
}

