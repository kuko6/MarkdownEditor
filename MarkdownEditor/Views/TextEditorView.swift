//
//  TextEditor.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct TextEditorView: View {
    @Environment(\.colorScheme) var currentMode
    @Binding var document: EditableDocument
    
    @State private var selectedExportType: UTType = .markdown
    @State private var isShowingExportDialog = false
    
    var theme: Color {
        currentMode == .light ? .white : .init(red: 30/255, green: 30/255, blue: 30/255)
    }
    
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
        .background(theme)
        .toolbar {
            ToolbarCommands(document: $document)
//            ToolbarItemGroup {
//                Menu {
//                    Button("Markdown") {
//                        isShowingExportDialog = true
//                        selectedExportType = .markdown
//                    }
//                    Button("PlainText") {
//                        isShowingExportDialog = true
//                        selectedExportType = .plainText
//                    }
//                    Button("HTML") {
//                        isShowingExportDialog = true
//                        selectedExportType = .html
//                    }
//                    Button("pdf") {
//                        isShowingExportDialog = true
//                        selectedExportType = .pdf
//                    }
//                } label: {
//                    Label("Export", systemImage: "square.and.arrow.up")
//                }
//                .fileExporter(isPresented: $isShowingExportDialog, document: document, contentType: selectedExportType) { results in }
//                .help("Export the document to:")
//            }
        }
    }
}

// MARK: - Preview
struct TextEditingView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(document: .constant(EditableDocument()))
    }
}
