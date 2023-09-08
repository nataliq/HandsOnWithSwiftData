import Foundation

@Observable
final public class Thought {
    public var text: String
    public var creationDate: Date

    public var tags: [Tag]

    public init(text: String, creationDate: Date = .now, tags: [Tag] = []) {
        self.text = text
        self.creationDate = creationDate
        self.tags = tags
    }
}

extension Thought: Identifiable, Hashable {
    public static func == (lhs: Thought, rhs: Thought) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}
