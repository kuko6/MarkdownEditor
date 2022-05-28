//
//  TextEditor.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI
import Ink

struct TextEditorView: View {
    @State private var fullText: String = "some _editable_ **text** and some `code`"
    
    var text: AttributedString {
        fullText.markdownToAttributed()
    }
    
    let inlineCodeMod = Modifier(target: .inlineCode) { html, markdown in
        var newHtml = html
        newHtml.insert(contentsOf: " style=\"padding:2px;background-color:#f1f1f1;border-radius:4px;\"", at: html.firstIndex(of: ">")!)
        return newHtml
    }
    
    var html: String {
        var parser = MarkdownParser()
        parser.addModifier(inlineCodeMod)
        
        let html = parser.html(from: fullText)
        //print(html)
        return html
    }
    
    var body: some View {
        HStack() {
            TextEditor(text: $fullText)
                .font(.body)
                .lineSpacing(2)
                .disableAutocorrection(true)
                .allowsTightening(false)
            WebView(html: html)
//            Text(text)
//                .multilineTextAlignment(.leading)
//                .font(.system(size: 13))
//                .lineSpacing(2)
        }
    }
}

extension String {
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self) // convert to AttributedString
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}

struct TextEditingView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
            .preferredColorScheme(.light)
            
    }
}
