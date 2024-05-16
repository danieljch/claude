//
//  ContentOO.swift
//  claude
//
//  Created by Daniel Jesus Callisaya Hidalgo on 16/5/24.
//

import Foundation
import SwiftUI
import Combine

class ContentOO: ObservableObject {
    @Published var items: [ContentDO] = []
    @Published var currentIndex: Int = 0
    
    init() {
        fetchContent()
    }
    
    func fetchContent() {
        items = [
            ContentDO(contentType: .bundleImage(name: "image1")),
            ContentDO(contentType: .bundleImage(name: "image2")),
            ContentDO(contentType: .sfSymbol(name: "star.fill")),
            ContentDO(contentType: .sfSymbol(name: "heart.fill")),
            ContentDO(contentType: .shape(.circle)),
            ContentDO(contentType: .shape(.rectangle)),
            ContentDO(contentType: .shape(.roundedRectangle(cornerRadius: 25)))
        ]
    }
    
    func nextImage() {
        currentIndex = (currentIndex + 1) % items.count
        print("Cambio a la imagen: \(currentIndex + 1) / \(items.count)")
    }
}
