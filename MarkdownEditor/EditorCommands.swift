//
//  MarkdownEditorCommands.swift
//  MarkdownEditor
//
//  Created by kuko on 01/06/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct EditorCommands: Commands {
    @State private var selectedExportType: UTType = .markdown
    @State private var isShowingExportDialog = false
    
    var document: EditableDocument
    
    var body: some Commands {
        SidebarCommands() // automatically adds commands for sidebar
        CommandGroup(after: .saveItem) {
            Menu("Export") {
                Button("To Markdown") {
                    isShowingExportDialog = true
                    selectedExportType = .markdown
                }
                Button("To PlainText") {
                    isShowingExportDialog = true
                    selectedExportType = .plainText
                }
                Button("To Html") {
                    isShowingExportDialog = true
                    selectedExportType = .html
                }
//                Button("To pdf") {
//                    isShowingExportDialog = true
//                    selectedExportType = .pdf
//                }
            }
            .fileExporter(isPresented: $isShowingExportDialog, document: document, contentType: selectedExportType) { results in }
        }
    }
}
