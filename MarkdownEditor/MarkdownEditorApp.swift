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
//                .focusedSceneValue(\.document, file.$document)
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
            CommandGroup(before: .newItem) {
                Button(action: {
                    if let currentWindow = NSApp.keyWindow,
                       let windowController = currentWindow.windowController {
                        windowController.newWindowForTab(nil)
                        if let newWindow = NSApp.keyWindow, currentWindow != newWindow {
                            currentWindow.addTabbedWindow(newWindow, ordered: .above)
                        }
                    }
                }, label: {
                    Text("New Tab")
                })
                .keyboardShortcut("t", modifiers: [.command])
            }
        }
        Settings {
//           Text("The app's settings!")
        }
    }
}
