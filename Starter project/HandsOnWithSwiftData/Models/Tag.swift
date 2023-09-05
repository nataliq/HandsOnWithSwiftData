import Foundation

@Observable
final public class Tag {
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
}

extension Tag: Identifiable, Hashable {
    public static func == (lhs: Tag, rhs: Tag) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}
