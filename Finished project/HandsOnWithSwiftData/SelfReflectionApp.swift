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
    }
}
