//
//  MarkdownEditorCommands.swift
//  MarkdownEditor
//
//  Created by kuko on 01/06/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct EditorCommands: Commands {
    //@FocusedBinding(\.selectedExportType) var selectedExportType
    @State private var selectedExportType: UTType = .text
    @State private var isShowingExportDialog = false
    
    //private var text = "lalalalal"
    var document: EditableDocument
    
//    func showSavePanel(exportType: UTType) {
//        let savePanel = NSSavePanel()
//        savePanel.allowedContentTypes = [exportType]
//        savePanel.canCreateDirectories = true
//        savePanel.isExtensionHidden = false
//        savePanel.allowsOtherFileTypes = false
//        savePanel.title = "Save your text"
//        savePanel.message = "Choose a folder and a name to store your text."
//        savePanel.nameFieldLabel = "File name:"
//
//        let response = savePanel.runModal()
//        let saveURL = response == .OK ? savePanel.url : nil
//        exportText(to: saveURL)
//    }
//
//    func exportText(to url: URL?) {
//        guard let url = url else { return }
//        try? document.text.write(to: url, atomically: true, encoding: .utf8)
//    }
    
    var body: some Commands {
        SidebarCommands() // automatically adds commands for sidebar
        CommandGroup(after: .saveItem) {
            Menu("Export") {
                Button("To Markdown") {
                    isShowingExportDialog = true
                    selectedExportType = .text
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

//private struct SelectedExportTypeKey: FocusedValueKey {
//    typealias Value = Binding<ExportType>
//}
//
//extension FocusedValues {
//    var selectedExportType: Binding<ExportType>? {
//        get { self[SelectedExportTypeKey.self] }
//        set { self[SelectedExportTypeKey.self] = newValue }
//    }
//}
