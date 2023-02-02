//
//  ToolbarCommands.swift
//  MarkdownEditor
//
//  Created by kuko on 08/06/2022.
//

import SwiftUI
import UniformTypeIdentifiers

// Doesnt work for some reason
struct ToolbarCommands: ToolbarContent {
    @State private var selectedExportType: UTType = .markdown
    @State private var isShowingExportDialog = false
    
    @Binding var document: EditableDocument
        
    var body: some ToolbarContent {
        ToolbarItemGroup {
            Menu {
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
            } label: {
                Image(systemName: "arrow.up.doc")
            }
            .fileExporter(isPresented: $isShowingExportDialog, document: document, contentType: selectedExportType) { results in }
        }
    }
}
