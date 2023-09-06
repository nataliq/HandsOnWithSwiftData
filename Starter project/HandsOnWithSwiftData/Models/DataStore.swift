import Foundation
import Observation

@Observable
final public class DataStore {
    static let shared = DataStore()
    private(set) var thoughts = [Thought]()
    private(set) var tags = [Tag]()
    
    func createThought(_ thought: Thought) {
        thoughts.append(thought)
    }
    
    func createTag(_ tag: Tag) {
        tags.append(tag)
    }

    func remove(_ thought: Thought) {
        if let thoughtIndex = thoughts.firstIndex(where: { $0 == thought}) {
            thoughts.remove(at: thoughtIndex)
        }
    }
}

