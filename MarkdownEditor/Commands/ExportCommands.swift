//
//  MarkdownEditorCommands.swift
//  MarkdownEditor
//
//  Created by kuko on 01/06/2022.
//

import SwiftUI
import UniformTypeIdentifiers

// Doesnt really work, because of the document binding in MarkdownEditorApp
struct ExportCommands: Commands {
    @State private var selectedExportType: UTType = .markdown
    @State private var isShowingExportDialog = false
    
    @FocusedBinding(\.document) var document
    
    var body: some Commands {
        CommandGroup(after: .saveItem) {
            Menu("Export") {
                Button("To markdown") {
                    isShowingExportDialog = true
                    selectedExportType = .markdown
                }
                Button("To plaintext") {
                    isShowingExportDialog = true
                    selectedExportType = .plainText
                }
                Button("To html") {
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
