import Foundation
import SwiftUI

struct ImportModelDataButton: View {
    enum ImportStatus {
        case notStarted, importing, imported

        var label: String {
            switch self {
            case .notStarted:
                return "Import"
            case .importing:
                return "Importing..."
            case .imported:
                return "Imported"
            }
        }
    }

    @State private var importStatus = ImportStatus.notStarted

    var body: some View {
        Button(importStatus.label) {
            importStatus = .importing
                importDataAndMarkAsImported()
        }
        .disabled(importStatus != .notStarted)
    }

    private func importDataAndMarkAsImported() {
        // TODO: create dummy models, save them and update the status accordingly
    }
}
