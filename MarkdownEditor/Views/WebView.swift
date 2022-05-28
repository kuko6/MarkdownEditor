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
        
        self.html = "<head><style>\(cssString)</style></head><body>\(html)</body>"
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
