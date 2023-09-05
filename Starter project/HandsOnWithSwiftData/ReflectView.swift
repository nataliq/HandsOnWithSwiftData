import Foundation
import SwiftUI

struct ReflectView: View {

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
        let thought = Thought(text: text, tags: selectedTags)
        DataStore.shared.thoughts.append(thought)
        
        text.removeAll()
        selectedTags.removeAll()
    }
}
