//
//  MarkdownEditorApp.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI

@main
struct MarkdownEditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: EditableDocument()) { file in
            ContentView(document: file.$document)
                .frame(minWidth: 800, idealWidth: 1200, minHeight: 400, idealHeight: 900)
//            NavigationView {
//                Text("Sidebar")
//                ContentView(document: file.$document)
//                    .frame(minWidth: 800, idealWidth: 1200, minHeight: 400, idealHeight: 900)
//            }
        }
        .commands {
            SidebarCommands() // automatically adds commands for sidebar
//            EditorCommands(document: $document)
        }
        Settings {
            
        }
    }
}
