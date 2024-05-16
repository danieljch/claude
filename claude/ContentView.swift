//
//  ContentView.swift
//  claude
//
//  Created by Daniel Jesus Callisaya Hidalgo on 15/5/24.
//
import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var oo = ContentOO()
    
    var body: some View {
        VStack {
            if !oo.items.isEmpty {
                GeneralizedImageView(content: oo.items[oo.currentIndex])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                
                Button("Next Image") {
                    oo.nextImage()
                }
                .padding()
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .imageChange, object: nil, queue: .main) { _ in
                oo.nextImage()
            }
        }
    }
}

extension Notification.Name {
    static let imageChange = Notification.Name("imageChange")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
