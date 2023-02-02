//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: EditableDocument
    
    var body: some View {
        TextEditorView(document: $document)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(EditableDocument()))
            .preferredColorScheme(.light)
    }
}
