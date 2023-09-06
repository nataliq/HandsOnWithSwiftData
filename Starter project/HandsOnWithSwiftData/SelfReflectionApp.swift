import SwiftUI
import SwiftData

@main
struct SelfReflectionApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .tint(.purple)
        }
        .modelContainer(for: Thought.self)
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
