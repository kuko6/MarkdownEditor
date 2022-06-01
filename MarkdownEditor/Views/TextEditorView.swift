//
//  TextEditor.swift
//  MarkdownEditor
//
//  Created by kuko on 23/05/2022.
//

import SwiftUI
import Ink

struct TextEditorView: View {
    @Environment(\.colorScheme) var currentMode
    
    @State private var fullText: String = """
    # Test

    Some _editable_ **text** and some `code`.

    ## Table
    | Header | Header 2 |
    | ------ | -------- |
    | Row 1  | Cell 1   |
    | Row 2  | Cell 2   |


    We used the following code for user verification:
    ```
    // Middleware for verifying the auth token for requests with userID
    const verifyUserID = (req, res, next) => {
        if (req.params.id != req.jwtPayload._id) {
            return res.status(401).send({ error: { message: 'Invalid auth-token' } });
        }
        next();
    };
    ```
    This method is used to verify the users JWT token :)
    """
    
    let inlineCodeMod = Modifier(target: .inlineCode) { html, markdown in
        var newHtml = html
        newHtml.insert(contentsOf: " style=\"padding:2px;border-radius:4px;\"", at: html.firstIndex(of: ">")!)
        return newHtml
    }
    
    var generatedHtml: String {
        var parser = MarkdownParser()
        parser.addModifier(inlineCodeMod)
        
        let html = parser.html(from: fullText)
        //print(html)
        return html
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextEditor(text: $fullText)
                .font(.body)
                .lineSpacing(2)
                .disableAutocorrection(true)
                .allowsTightening(false)
                .padding([.top, .leading, .bottom], 4)
            Divider()
            WebView(html: generatedHtml, currentMode: currentMode)
        }
        .background(currentMode == .light ? .white : .init(red: 30/255, green: 30/255, blue: 30/255))
    }
}

struct TextEditingView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}
