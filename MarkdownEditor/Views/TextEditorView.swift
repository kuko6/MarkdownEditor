//
//  TextEditor.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI
import Ink

struct TextEditorView: View {
    @Environment(\.colorScheme) var currentMode
    
    @Binding var document: EditableDocument
    
//    let inlineCodeMod = Modifier(target: .inlineCode) { html, markdown in
//        var newHtml = html
//        newHtml.insert(contentsOf: " style=\"padding:2px;border-radius:4px;\"", at: html.firstIndex(of: ">")!)
//        return newHtml
//    }
//
//    var generatedHtml: String {
//        var parser = MarkdownParser()
//        parser.addModifier(inlineCodeMod)
//
//        let html = parser.html(from: document.text)
//        //print(html)
//        return html
//    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextEditor(text: $document.text)
                .font(.body)
                .lineSpacing(2)
                .disableAutocorrection(true)
                .allowsTightening(false)
                .padding([.top, .leading, .bottom], 4)
            Divider()
//            Button("Test") {
//                document.html = ParseMarkdown(text: document.text, currentMode: currentMode)
//            }
            WebView(html: document.text, currentMode: currentMode)
        }
        .background(currentMode == .light ? .white : .init(red: 30/255, green: 30/255, blue: 30/255))
    }
}

//struct TextEditingView_Previews: PreviewProvider {
//    @State var document: EditableDocument = EditableDocument()
//    
//    static var previews: some View {
//        TextEditorView(document: $document)
//    }
//}
