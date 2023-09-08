import Foundation
import SwiftUI
import SwiftData
import OSLog

struct ImportModelDataButton: View {
    @Environment(\.modelContext) private var modelContext
    
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
//        // This shouldn't be possible - the compiler should warn us
//        // for using `modelContext` from a non-main actor, similarly
//        // to how it warns us if we try to use `modelContext.container.mainContext`
//        // (which is exactly the same instance):
//        // "Non-sendable type 'ModelContext' in implicitly asynchronous access
//        // to main actor-isolated property 'mainContext' cannot cross actor boundary".
//        // TODO: open a feedback request with Apple
//        Task.detached {
//            for index in 0..<50000 {
//                let object = Thought(text: "\(index)")
//                await modelContext.insert(object)
//            }
//            try modelContext.save()
//        }
        Task.detached(priority: .userInitiated) {
            let clock = ContinuousClock()
            let elapsed = await clock.measure {
                let actor = ThoughtsActor(modelContainer: modelContext.container)
                do {
                    try await actor.importLargeSetOfDummyData(numberOfEntries: 50000)
                    await MainActor.run {
                        importStatus = .imported
                    }
                } catch {
                    fatalError("Error importing data: \(error)")
                }
            }
            let logger = Logger(subsystem: "Editor", category: "Import")
            logger.info("Import took \(elapsed) seconds")
        }
    }
}

// This is the recommended way for using SwiftData in a multi-threaded environment.
// Also see: https://useyourloaf.com/blog/swiftdata-background-tasks/
actor ThoughtsActor: ModelActor {
    let modelContainer: ModelContainer
    let modelExecutor: any ModelExecutor
    
    init(modelContainer: ModelContainer = AppContainer.shared) {
        self.modelContainer = modelContainer
        let context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }
    
    func importLargeSetOfDummyData(numberOfEntries: Int, batchSize: Int = 10000) throws {
        for startIndex in stride(from: 1, through: numberOfEntries + 1, by: batchSize) {
            let endIndex = min(startIndex + batchSize, numberOfEntries + 1)
            for index in startIndex..<endIndex {
                let object = Thought(text: "\(index)")
                modelContext.insert(object)
            }
            try modelContext.save()
        }
    }
}
