//
//  GeneralizedImageView.swift
//  claude
//
//  Created by Daniel Jesus Callisaya Hidalgo on 16/5/24.
//

import SwiftUI

struct GeneralizedImageView: View {
    let content: ContentDO
    @State private var state: ImageState = .intro
    @State private var opacity: Double = 0.0
    @State private var position: CGPoint = .zero
    
    enum ImageState {
        case intro
        case onScreen
        case exit
    }
    
    var body: some View {
        getImageView()
            .opacity(opacity)
            .position(position)
            .onAppear {
                startIntro()
            }
            .onChange(of: content.id) { _ in
                state = .intro
                opacity = 0.0
                position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                startIntro()
            }
    }
    
    private func getImageView() -> some View {
        switch content.contentType {
        case .bundleImage(let name):
            return Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .eraseToAnyView()
            
        case .sfSymbol(let name):
            return Image(systemName: name)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .eraseToAnyView()
            
        case .shape(let shapeType):
            switch shapeType {
            case .circle:
                return Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .eraseToAnyView()
            case .rectangle:
                return Rectangle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
                    .eraseToAnyView()
            case .roundedRectangle(let cornerRadius):
                return RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.purple)
                    .frame(width: 100, height: 100)
                    .eraseToAnyView()
            }
        }
    }
    
    private func startIntro() {
        print("Estado: Intro")
        state = .intro
        opacity = 0.0
        position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        withAnimation(.easeIn(duration: 2)) {
            opacity = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            startOnScreen()
        }
    }
    
    private func startOnScreen() {
        print("Estado: OnScreen")
        state = .onScreen
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        let points = [
            CGPoint(x: CGFloat.random(in: 50...(width - 50)), y: CGFloat.random(in: 50...(height - 50))),
            CGPoint(x: CGFloat.random(in: 50...(width - 50)), y: CGFloat.random(in: 50...(height - 50))),
            CGPoint(x: CGFloat.random(in: 50...(width - 50)), y: CGFloat.random(in: 50...(height - 50)))
        ]
        
        withAnimation(.linear(duration: 2.66)) {
            position = points[0]
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.66) {
            withAnimation(.linear(duration: 2.66)) {
                position = points[1]
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.33) {
            withAnimation(.linear(duration: 2.66)) {
                position = points[2]
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            startExit()
        }
    }
    
    private func startExit() {
        print("Estado: Exit")
        state = .exit
        
        withAnimation(.easeOut(duration: 2)) {
            opacity = 0.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: .imageChange, object: nil)
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

struct GeneralizedImageView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralizedImageView(content: ContentDO(contentType: .sfSymbol(name: "star.fill")))
    }
}

