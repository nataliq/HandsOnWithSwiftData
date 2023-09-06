import Foundation
import SwiftData

@Model
final public class Thought {
    public var text: String
    public var creationDate: Date

//    @Relationship(inverse: \Tag.thoughts)
    public var tags: [Tag]

    public init(text: String, creationDate: Date = .now) {
        self.text = text
        self.creationDate = creationDate
        self.tags = []
    }
}
