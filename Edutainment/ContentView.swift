//
//  ContentView.swift
//  Edutainment
//
//  Created by ramsayleung on 2024-01-06.
//

import SwiftUI

struct ContentView: View {
    @State private var tableSize = 3
    @State private var questionAmount = 5
    
    let letters = "Edutainment"
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView()
                VStack {
                    ZStack {
                        Text(letters)
                            .font(.custom("K26ToyBlocks123", size: 35))
                            .foregroundColor(.brown)
                    }
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial)
                    )
                    .padding(.horizontal, 10)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack(spacing: 10) {
                        Text("Select a Multiplication Table: ")
                            .font(.custom("Salsa-Regular", size: 28))
                            .foregroundStyle(.brown)
                            .padding(.top, 20)
                        
                        HStack {
                            ZStack {
                                BackgroundFrame(width: 80, height: 60)
                                Text("x \(tableSize)")
                                    .font(.custom("Salsa-Regular", size: 30))
                                    .animation(.bouncy)
                                    .foregroundColor(.brown)
                            }
                            Stepper("Table \(tableSize)", value: $tableSize, in: 2...12)
                                .labelsHidden()
                                .animation(.default, value: tableSize)
                        }
                        
                        Text("How many questions?")
                            .font(.custom("Salsa-Regular", size: 28) )
                            .foregroundStyle(.brown)
                        
                        Picker("", selection: $questionAmount){
                            ForEach([5,10,15], id: \.self){
                                Text("\($0)")
                                    .font(.custom("Salsa-Regular", size: 30))
                                    .foregroundStyle(.brown)
                                    .animation(.bouncy, value: questionAmount)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 250, alignment: .center)
                        
                        PlayButtonView(tableSize: tableSize, questionAmount: questionAmount)
                        
                    }.frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.thinMaterial)
                        )
                        .padding(.horizontal, 10)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
