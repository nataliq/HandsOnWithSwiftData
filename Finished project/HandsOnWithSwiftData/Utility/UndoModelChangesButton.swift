import Foundation
import SwiftUI
import SwiftData

struct UndoModelChangesButton: View {
    @Environment(\.modelContext) private var modelContext
    @State private var canUndo: Bool? = false

    // This might not be the best approach but it's an interesting one
    // that I think is worth showing. Sometimes if SwiftData is missing
    // a feature we need, we can try to deduct some useful information
    // by inspecting the backing Core Data stack (which can change anytime
    // so we can't blindly rely on it - it needes to be tested).
    private let coreDataObjectsDidChange = NotificationCenter.default.publisher(
        for: .NSManagedObjectContextObjectsDidChange
    )

    var body: some View {
        Button {
            modelContext.undoManager?.undo()
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
        }
        // `canUndo` is not observable, we need another trigger for updating
        // the button's enabled/diabled state
        .disabled(canUndo != true)
        .onAppear { updateUndoAvailability() }
        .onReceive(coreDataObjectsDidChange) { _ in updateUndoAvailability() }
    }

    private func updateUndoAvailability() {
        self.canUndo = modelContext.undoManager?.canUndo
    }
}
