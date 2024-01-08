//
//  PlayButtonView.swift
//  Edutainment
//
//  Created by ramsayleung on 2024-01-07.
//

import SwiftUI

struct PlayButtonView: View {
    let tableSize: Int
    let questionAmount: Int
    
    @State private var isPlaying = false
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            BackgroundFrame(width: 150, height: 70)
            
            Button{
                isPressed.toggle()
                // Navigate to the question view until the animation finishs
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isPlaying = true
                }
            } label: {
                Image("rounded_wd_chicken")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle.degrees(isPressed ? 360 : 0))
                    .animation(.easeInOut(duration: 1.0), value: isPlaying)
                
                Text("Play")
                    .font(.custom("VT323-Regular", size: 30))
                    .foregroundColor(isPressed ? .green : .brown)
                    .animation(.spring(duration: 1, bounce: 0.9))
            }
            .scaleEffect(isPressed ? 1.05 : 1)
            .animation(.spring(duration: 1, bounce: 0.9), value: isPlaying)
            .navigationDestination(isPresented: $isPlaying, destination: {
                QuestionView(multiplicationTableCapacity: tableSize, questionAmount: questionAmount)
            })
        }.padding(.vertical, 20)
    }
}
