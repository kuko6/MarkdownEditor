//
//  ExportType.swift
//  MarkdownEditor
//
//  Created by kuko on 01/06/2022.
//

import SwiftUI

enum ExportType: String, CaseIterable, Identifiable {
    case pdf = "pdf"
    case md = "md"
    case html = "html"
    
    var id: ExportType { self }
}
