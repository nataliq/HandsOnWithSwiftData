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
        let thought = Thought(text: text)
        modelContext.insert(thought)
        thought.tags = selectedTags
        
        text.removeAll()
        selectedTags.removeAll()
    }
}
