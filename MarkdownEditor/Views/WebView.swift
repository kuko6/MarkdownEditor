//
//  WebView.swift
//  MarkdownEditor
//
//  Created by kuko on 28/05/2022.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    var currentMode: ColorScheme
    var html: String

    init(html: String, currentMode: ColorScheme) {
        self.currentMode = currentMode
        self.html = ParseMarkdown(text: html, colorTheme: currentMode).toStyledHtml()
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: nil)
    }
}

// MARK: - Preview
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: "<h1>Ide to?</h1><p> Asi to funguje </p>", currentMode: .light)
    }
}
