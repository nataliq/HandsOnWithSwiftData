import Foundation
import SwiftUI

struct BrowseView: View {
    @State private var searchTerm: String = ""

    private var thoughts = DataStore.shared.thoughts

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
        DataStore.shared.remove(thought)
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

