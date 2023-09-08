import Foundation
import SwiftData

@Model
final public class Thought {
    public var text: String
    public var creationDate: Date

    // Using @Relationship is not necessary if the relationship is tagged
    // on the other side and if the default parameters work for us.
    public var tags: [Tag]

    public init(text: String, creationDate: Date = .now) {
        self.text = text
        self.creationDate = creationDate
        self.tags = []
    }
}
