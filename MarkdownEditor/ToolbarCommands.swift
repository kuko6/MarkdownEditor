//
//  ToolbarCommands.swift
//  MarkdownEditor
//
//  Created by kuko on 08/06/2022.
//

import SwiftUI
import UniformTypeIdentifiers

// Doesnt work for some reason, idk
struct ToolbarCommands: ToolbarContent {
    @State private var selectedExportType: UTType = .markdown
    @State private var isShowingExportDialog = false
    
    var document = EditableDocument()
        
    var body: some ToolbarContent {
        ToolbarItemGroup {
            Menu {
                Button("To Markdown") {
                    isShowingExportDialog = true
                    selectedExportType = .markdown
                }
                Button("To PlainText") {
                    isShowingExportDialog = true
                    selectedExportType = .plainText
                }
                Button("To HTML") {
                    isShowingExportDialog = true
                    selectedExportType = .html
                }
//                Button("To pdf") {
//                    isShowingExportDialog = true
//                    selectedExportType = .pdf
//                }
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            .fileExporter(isPresented: $isShowingExportDialog, document: document, contentType: selectedExportType) { results in }
        }
    }
}
