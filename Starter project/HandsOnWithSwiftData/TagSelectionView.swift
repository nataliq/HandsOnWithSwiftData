import Foundation
import SwiftUI

struct TagSelectionView: View {
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
        DataStore.shared.tags.append(tag)
        selectedTags.append(tag)
        suggestedTagName.removeAll()
    }
}

private struct TagCloud: View {
    private var allTags: [Tag]
    @Binding var selectedTags: [Tag]
    @Binding var suggestedTagName: String

    var temporaryTag: Tag?

    init(suggestedTagName: Binding<String>, selectedTags: Binding<[Tag]>) {
        let searchTerm = suggestedTagName.wrappedValue
        self._suggestedTagName = suggestedTagName
        allTags = DataStore.shared.tags.containingText(searchTerm)
        self._selectedTags = selectedTags

        self.temporaryTag = createNewTagSuggestionFromSearch(searchTerm)
    }

    var body: some View {
        FlowLayout(alignment: .center) {
            if allTags.isEmpty, let temporaryTag {
                TagCloudBubble(text: "New: " + temporaryTag.name, isSelected: false)
                    .onTapGesture {
                        selectedTags.append(temporaryTag)
                        
                        DataStore.shared.tags.append(temporaryTag)
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

    private func createNewTagSuggestionFromSearch(_ searchTerm: String) -> Tag? {
        guard searchTerm.isEmpty == false else { return nil }
        let tag = Tag(name: searchTerm)
        return tag
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
