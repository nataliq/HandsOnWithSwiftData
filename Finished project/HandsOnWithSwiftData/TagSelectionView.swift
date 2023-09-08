import Foundation
import SwiftUI
import SwiftData

struct TagSelectionView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var suggestedTagName = ""
    @Binding var selectedTags: [Tag]

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Find or add an option", text: $suggestedTagName)
                .onSubmit {
                    saveTagFromSuggestionAndSeletIt()
                }
        }

        TagCloud(suggestedTagName: $suggestedTagName, selectedTags: $selectedTags)
    }

    private func saveTagFromSuggestionAndSeletIt() {
        let tag = Tag(name: suggestedTagName)
        modelContext.insert(tag)
        selectedTags.append(tag)
        suggestedTagName.removeAll()
    }
}

private struct TagCloud: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var allTags: [Tag]
    @Binding var selectedTags: [Tag]
    @Binding var suggestedTagName: String

    init(suggestedTagName: Binding<String>, selectedTags: Binding<[Tag]>) {
        let searchTerm = suggestedTagName.wrappedValue
        self._suggestedTagName = suggestedTagName
        if searchTerm.isEmpty == false {
            _allTags = Query(
                filter: #Predicate { $0.name.localizedStandardContains(searchTerm) }
            )
        } else {
            _allTags = Query()
        }
        self._selectedTags = selectedTags
    }

    var body: some View {
        FlowLayout(alignment: .center) {
            if allTags.isEmpty, suggestedTagName.isEmpty == false {
                TagCloudBubble(text: "New: " + suggestedTagName, isSelected: false)
                    .onTapGesture {
                        let tag = Tag(name: suggestedTagName)
                        modelContext.insert(tag)
                        selectedTags.append(tag)
                        suggestedTagName.removeAll()
                    }
            } else {
                ForEach(allTags) { tag in
                    TagCloudBubble(text: tag.name, isSelected: selectedTags.contains(tag))
                        .onTapGesture {
                            selectedTags.toggle(tag)
                        }
                }
            }
        }
    }
}

private struct TagCloudBubble: View {
    var text: String
    var isSelected: Bool

    var body: some View {
        HStack {
            Text(text)
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
        }
        .padding()
        .foregroundColor(isSelected ? .white : .black)
        .background(isSelected ? Color.purple : Color.gray.opacity(0.2))
        .cornerRadius(.infinity)
    }
}

extension Array {
    mutating func toggle(_ element: Element) where Element: Equatable {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
        } else {
            self.append(element)
        }
    }
}
