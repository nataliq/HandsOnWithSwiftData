import Foundation
import SwiftData

@Model
final public class Tag {
    public var name: String
    
    public var thoughts: [Thought]
    
    public init(name: String, thoughts: [Thought] = []) {
        self.name = name
        self.thoughts = thoughts
    }
}
