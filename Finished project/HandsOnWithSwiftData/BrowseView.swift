import Foundation
import SwiftUI
import SwiftData

struct BrowseView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchTerm: String = ""
    var body: some View {
        NavigationStack {
            // A workaround for the currently missing support for dynamic queries:
            // The list view should be extracted to its own view
            // so that we can pass the search term through the initializer.
            // That way we can modify the @Query whenever the search changes.
            ThoughtsListView(searchTerm: searchTerm)
                .searchable(
                    text: $searchTerm,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        UndoModelChangesButton()
                    }
                }
        }
    }
}

struct ThoughtsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var thoughts: [Thought]
    
    init(searchTerm: String) {
        _thoughts = Thought.all(filteredBy: searchTerm)
    }
    
    var body: some View {
        if thoughts.isEmpty {
            EmptyView()
        } else {
            List(thoughts) { thought in
                NavigationLink(thought.text) {
                    ThoughtEditorView(thought: thought)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        deleteThought(thought)
                    } label: {
                        Label("Archive", systemImage: "archivebox")
                    }
                }
            }
            .navigationTitle("List")
        }
    }
    
    private func deleteThought(_ thought: Thought) {
        modelContext.delete(thought)
    }
    
}

private extension Thought {
    static func all(filteredBy searchTerm: String) -> Query<Thought, [Thought]> {
        if searchTerm.isEmpty == false {
            return Query(
                filter: #Predicate { $0.text.localizedStandardContains(searchTerm) },
                sort: \Thought.creationDate,
                order: .reverse
            )
        } else {
            return Query(sort: \Thought.creationDate, order: .reverse)
        }
    }
}

private struct EmptyView: View {
    var body: some View {
        ContentUnavailableView(
            "Empty",
            systemImage: "square.stack.3d.up.slash",
            description: Text("Go to \"Reflect\" tab to create a new one.")
        )
    }
}

