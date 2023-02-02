//
//  EditableDocument.swift
//  MarkdownEditor
//
//  Created by kuko on 02/06/2022.
//

import SwiftUI
import UniformTypeIdentifiers

// Adding imported and exported file types used by our app
extension UTType {
    static var markdown: UTType {
        UTType(importedAs: "net.daringfireball.markdown")
    }
    
//    static var pdt: UTType {
//        UTType(importedAs: "net.daringfireball.markdown")
//    }
}

final class EditableDocument: FileDocument, ObservableObject {
    static var readableContentTypes = [UTType.markdown, UTType.plainText, UTType.html]
    
    var text: String
    var html = "<p>Ahojky</p>"
    
    init() {
        text = """
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
    }
    
    // Loads previously saved data from file
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
            let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    // Used for saving the data
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        var data: Data
        
        //print(configuration.contentType.description)
        if (configuration.contentType.description.hasSuffix(".html")) {
            data = ParseMarkdown(text: text, colorTheme: ColorScheme.dark).toStyledHtml().data(using: .utf8)!
        } else {
            data = text.data(using: .utf8)!
        }
        
        return .init(regularFileWithContents: data)
    }
}
