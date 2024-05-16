//
//  ContentDO.swift
//  claude
//
//  Created by Daniel Jesus Callisaya Hidalgo on 16/5/24.
//

import SwiftUI

enum ContentType {
    case bundleImage(name: String)
    case sfSymbol(name: String)
    case shape(ShapeType)
}

enum ShapeType {
    case circle
    case rectangle
    case roundedRectangle(cornerRadius: CGFloat)
}

struct ContentDO: Identifiable {
    let id = UUID()
    let contentType: ContentType
}
