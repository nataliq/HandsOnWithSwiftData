import Foundation
import SwiftUI
import SwiftData

struct ReflectView: View {

    @Environment(\.modelContext) private var modelContext

    @State private var text: String = ""
    @State private var selectedTags: [Tag] = []

    private var shouldShowSave: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Text") {
                    ThoughtTextField(text: $text)
                        .onSubmit(save)
                    
                    ImportModelDataButton()
                }

                Section("Topics") {
                    TagSelectionView(selectedTags: $selectedTags)
                }
            }
            .navigationTitle("What's on your mind?")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if shouldShowSave {
                        Button("Save", action: save)
                    }
                }
            }
        }
    }

    private func save() {
        guard shouldShowSave else { return }
        
        // We insert the model object into a model context post-creation.
        // At the time of creation we can't establish relationships to
        // model objects fetched in a model context.
        // If we try to do that we will get a crash at runtime:
        // "Illegal attempt to establish a relationship '<relationship name>'
        // between objects in different contexts".
        let thought = Thought(text: text)
        modelContext.insert(thought)
        thought.tags = selectedTags
        
        text.removeAll()
        selectedTags.removeAll()
    }
}
