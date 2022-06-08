//
//  ParseMarkdown.swift
//  MarkdownEditor
//
//  Created by kuko on 02/06/2022.
//

import SwiftUI
import Ink

// Parse Markdown string to styled html
struct ParseMarkdown {
    var text: String
    var colorTheme: ColorScheme
    
    let inlineCodeMod = Modifier(target: .inlineCode) { html, markdown in
        var newHtml = html
        newHtml.insert(contentsOf: " style=\"padding:2px;border-radius:4px;\"", at: html.firstIndex(of: ">")!)
        return newHtml
    }
    
    var generatedHtml: String {
        var parser = MarkdownParser()
        parser.addModifier(inlineCodeMod)
        
        let html = parser.html(from: text)
        //print(html)
        return html
    }
    
    func toStyledHtml() -> String {
        var cssString = ""
        if let stylePath = Bundle.main.path(forResource: "Style", ofType: "css") {
            cssString = try! String(contentsOfFile: stylePath).trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            print("Could not load the css file!!")
        }
        
        let colorTheme = self.colorTheme == .light ? "github" : "github-dark"
        
        // TODO: - Change to static files
        let highlightjsHead = """
        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/styles/\(colorTheme).min.css\">
        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/highlight.min.js\"></script>
        """
        let highlightjsScript = "<script>hljs.initHighlightingOnLoad();</script>"
        
        return "<head><style>\(cssString)</style>\(highlightjsHead)</head><body>\(highlightjsScript)\(generatedHtml)</body>"
    }
}
