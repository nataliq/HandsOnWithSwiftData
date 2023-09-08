import Foundation
import SwiftUI
import SwiftData

struct BrowseView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchTerm: String = ""
    @Query private var thoughts: [Thought]
    @State private var selectedItem: Thought?

    var body: some View {
        NavigationStack {
            Group {
                if thoughts.isEmpty {
                    EmptyView()
                } else {
                    List(filteredThoughts) { thought in
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
                    .searchable(
                        text: $searchTerm,
                        placement: .navigationBarDrawer(displayMode: .automatic)
                    )
                }
            }
            .navigationTitle("List")
        }
    }

    private var filteredThoughts: [Thought] {
        thoughts.containingText(searchTerm)
    }

    private func deleteThought(_ thought: Thought) {
        modelContext.delete(thought)
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

