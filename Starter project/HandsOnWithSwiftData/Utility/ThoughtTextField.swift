import SwiftUI

struct ThoughtTextField: View {
    private enum Field {
        case text
    }
    
    private let prompt = "..."
    
    @Binding var text: String
    @FocusState private var focusedField: Field?
    
    var body: some View {
        TextField(prompt, text: $text, axis: .vertical)
            .multilineTextAlignment(.center)
            .padding()
            .focused($focusedField, equals: .text)
            .onAppear { focusedField = .text }
    }
}
