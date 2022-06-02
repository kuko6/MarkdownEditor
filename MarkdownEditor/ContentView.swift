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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.light)
//    }
//}
