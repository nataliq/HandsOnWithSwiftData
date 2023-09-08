import Foundation

protocol TextSearchable {
    var textKeyPath: KeyPath<Self, String> { get }
}

extension Array where Element: TextSearchable {
    func containingText(_ searchTerm: String) -> [Element] {
        guard searchTerm.isEmpty == false else {
            return self
        }
        return self.filter {
            $0[keyPath: $0.textKeyPath].localizedStandardContains(searchTerm)
        }
    }
}

extension Thought: TextSearchable {
    var textKeyPath: KeyPath<Thought, String> {
        \.text
    }
}

extension Tag: TextSearchable {
    var textKeyPath: KeyPath<Tag, String> {
        \.name
    }
}
