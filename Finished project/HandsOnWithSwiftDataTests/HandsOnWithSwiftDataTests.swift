import XCTest
@testable import HandsOnWithSwiftData
import SwiftData

final class HandsOnWithSwiftDataTests: XCTestCase {
    
    @MainActor
    func testModelCreation() throws {
        let container = try ModelContainer(
            for: Thought.self, Tag.self,
            configurations: .init(isStoredInMemoryOnly: true)
        )
        
        let context = container.mainContext
        
        let tagNames = (1...10).map(String.init)
        let tags = tagNames.map {
            let tag = Tag(name: $0)
            context.insert(tag)
            return tag
        }
        
        let thought = Thought(text: "test")
        thought.tags = tags
        
        // This fails - even thought the `tags` relationship is
        // represented by the `Array` type, its order cannot be
        // guaranteed to be the same as when the objects were created.
        // To preserve the order we nee to introduce an attribute to sort by.
        XCTAssertEqual(thought.tags.map { $0.name }, tagNames)
    }
}

