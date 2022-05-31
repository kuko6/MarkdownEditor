//
//  WebView.swift
//  MarkdownEditor
//
//  Created by kuko on 28/05/2022.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    var html: String
    
    init(html: String) {
        var cssString = ""
        if let path = Bundle.main.path(forResource: "Style", ofType: "css") {
            cssString = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            print("Could not load the css file!!")
        }
        
        // TODO: - Change style to "github-dark" in dark mode and also change the background color for pre element in the css file
        let highlightjsHead = """
        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/styles/github.min.css\">
        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/highlight.min.js\"></script>
        """
        let highlightjsScript = "<script>hljs.initHighlightingOnLoad();</script>"

        self.html = "<head><style>\(cssString)</style>\(highlightjsHead)</head><body>\(highlightjsScript)\(html)</body>"
        // print(self.html)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: nil)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: "<h1>Ide to?</h1><p> Asi to funguje </p>")
    }
}
