import Foundation
import SwiftUI

struct UndoModelChangesButton: View {
    @State private var canUndo: Bool? = false

    var body: some View {
        Button {
            // TODO: trigger undo
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
        }
        .disabled(canUndo != true)
        .onAppear { updateUndoAvailability() }
    }

    private func updateUndoAvailability() {
        // TODO: update `canUdo`
    }
}
