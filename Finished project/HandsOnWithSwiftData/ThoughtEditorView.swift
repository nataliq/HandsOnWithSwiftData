import Foundation
import SwiftUI

struct ThoughtEditorView: View {

    @Bindable private var editedThought: Thought

    init(thought: Thought) {
        self.editedThought = thought
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Text") {
                    ThoughtTextField(text: $editedThought.text)
                }

                Section("Topics") {
                    TagSelectionView(selectedTags: $editedThought.tags)
                }
            }
            .navigationTitle("Edit")
        }
    }
}
