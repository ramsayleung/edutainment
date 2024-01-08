//
//  BackgroundView.swift
//  Edutainment
//
//  Created by ramsayleung on 2024-01-06.
//

import SwiftUI

struct BackgroundFrame: View {
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: width, height: height)
                .foregroundColor(.white)
                .opacity(0.9)
        }
    }
}

struct BackgroundGradient: View {
    let bubbleGumPink = Color(red: 9.9, green: 0.7, blue: 0.9)
    
    var body: some View {
        LinearGradient(stops: [
            .init(color: Color(.cyan), location: 0.5),
            .init(color: Color(.mint), location: 0.5)
        ], startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
    }
}

struct BackgroundCircle: View {
    let size: CGFloat
    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .foregroundColor(Color(red: 145/255, green: 189/255, blue: 245/255))
            .shadow(radius: 0, x: 5, y: 5)
    }
}

struct BackgroundView: View {
    struct ImageWrapper: Identifiable {
        let id = UUID()
        let image: Image
    }
    
    let images: [Image] = [
        Image("bear"),
        Image("buffalo"),
        Image("chick"),
        Image("chicken"),
        Image("cow"),
        Image("crocodile"),
        Image("dog"),
        Image("duck"),
        Image("elephant"),
        Image("frog"),
        Image("giraffe"),
        Image("goat"),
        Image("gorilla"),
        Image("hippo"),
        Image("horse"),
        Image("monkey"),
        Image("moose"),
        Image("narwhal"),
        Image("owl"),
        Image("panda"),
        Image("parrot"),
        Image("penguin"),
        Image("pig"),
        Image("rabbit"),
        Image("rhino"),
        Image("sloth"),
        Image("snake"),
        Image("walrus"),
        Image("whale"),
        Image("zebra")
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 5) {
                ForEach(images.map { ImageWrapper(image: $0) }) { imageWrapper in
                    imageWrapper.image
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                }
            }
        }
        .background(Color.white) // Set a background color for the grid
        .ignoresSafeArea()
    }
}
