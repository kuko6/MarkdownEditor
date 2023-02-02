//
//  MarkdownEditorApp.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI

struct DocumentFocusedValueKey: FocusedValueKey {
    typealias Value = Binding<EditableDocument>
}

extension FocusedValues {
    var document: DocumentFocusedValueKey.Value? {
        get {
            return self[DocumentFocusedValueKey.self]
        }
        
        set {
            self[DocumentFocusedValueKey.self] = newValue
        }
    }
}

@main
struct MarkdownEditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: EditableDocument()) { file in
//            ContentView(document: file.$document)
//                .frame(minWidth: 800, idealWidth: 1200, minHeight: 400, idealHeight: 900)
            NavigationView {
                Text("Sidebar")
                ContentView(document: file.$document)
                    .frame(minWidth: 800, idealWidth: 1200, minHeight: 400, idealHeight: 900)
                    .focusedSceneValue(\.document, file.$document)
            }
        }
        .commands {
            SidebarCommands() // automatically adds commands for sidebar
            ExportCommands()
        }
        Settings {
//           Text("The app's settings!")
        }
    }
}
