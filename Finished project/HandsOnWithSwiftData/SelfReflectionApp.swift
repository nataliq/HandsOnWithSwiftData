import SwiftUI
import SwiftData

@main
struct SelfReflectionApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .tint(.purple)
        }
        // Forgetting to add a model container results in an error:
        // "failed to find a currently active container for <model name>"
        .modelContainer(
            // No need to specify both `Thought.self` and `Tag.self`.
            // SwiftData can infer this from the relationship info in the models.
            // It might be a good a idea to be explicit though - to be safe if
            // relationships change in the future.
            for: Thought.self,
            // Providing this parameter affects the `undoManager` of all
            // model contexts derived from this container.
            isUndoEnabled: true
        )
    }
}

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            ReflectView()
                .tabItem {
                    Label("Reflect", systemImage: "square.and.pencil")
                }

            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "list.dash")
                }
        }
        .onAppear() {
            // This is a workaround for saving the container provided
            // by the `.modelContainer` modifier for creating an
            // instance on the fly. If we use the other initializer
            // that takes an injected instance we will loose the ability to provide
            // `isUndoEnabled` that propagates to all contexts.
            AppContainer.shared = modelContext.container
        }
    }
}

struct AppContainer {
    // We want to access the model container from an object
    // that is not a SwiftUI View, for example a ModelActor.
    static fileprivate(set) var shared: ModelContainer!
}
