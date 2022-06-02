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
    @State private var selectedExportType = ExportType.md
    
    private var text = "lalalalal"
    
    func showSavePanel() -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [UTType.text]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.allowsOtherFileTypes = false
        savePanel.title = "Save your text"
        savePanel.message = "Choose a folder and a name to store your text."
        savePanel.nameFieldLabel = "File name:"

        let response = savePanel.runModal()
        return response == .OK ? savePanel.url : nil
    }

    func exportText(to url: URL?) {
        guard let url = url else { return }
        try? text.write(to: url, atomically: true, encoding: .utf8)
    }
    
    var body: some Commands {
        SidebarCommands() // automatically adds commands for sidebar
        CommandGroup(after: .saveItem) {
            Button("Export...") {
                let saveURL = showSavePanel()
                exportText(to: saveURL)
            }
            .keyboardShortcut("s", modifiers: .command)
            Picker(selection: $selectedExportType, label: Text("Export")) {
                Text("Markdown").tag(ExportType.md)
                Text("pdf").tag(ExportType.pdf)
                Text("html").tag(ExportType.html)
            }
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
