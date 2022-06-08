//
//  TextEditor.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI

struct TextEditorView: View {
    @Environment(\.colorScheme) var currentMode
    @Binding var document: EditableDocument
    
    var body: some View {
        HStack(spacing: 0) {
            TextEditor(text: $document.text)
                .font(.body)
                .lineSpacing(2)
                .disableAutocorrection(true)
                .allowsTightening(false)
                .padding([.top, .leading, .bottom], 4)
            Divider()
            WebView(html: document.text, currentMode: currentMode)
        }
        .background(currentMode == .light ? .white : .init(red: 30/255, green: 30/255, blue: 30/255))
    }
}

// MARK: - Preview
struct TextEditingView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(document: .constant(EditableDocument()))
    }
}
