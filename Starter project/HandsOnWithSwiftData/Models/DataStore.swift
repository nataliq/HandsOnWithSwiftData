import Foundation
import Observation

@Observable
final public class DataStore {
    static let shared = DataStore()
    public var thoughts = [Thought]()
    public var tags = [Tag]()

    func remove(_ thought: Thought) {
        if let thoughtIndex = thoughts.firstIndex(where: { $0 == thought}) {
            thoughts.remove(at: thoughtIndex)
        }
    }
}

