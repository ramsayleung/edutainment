//
//  QuestionView.swift
//  Edutainment
//
//  Created by ramsayleung on 2024-01-07.
//

import SwiftUI

struct ScoreView: View {
    @Binding var isCorrect: Bool?
    @Binding var wrongAnswerCount: Int
    @Binding var correctAnswerCount: Int
    var body: some View {
        HStack {
            VStack{
                ZStack{
                    BackgroundFrame(width: 80, height: 70)
                    Text("❌")
                        .font(.largeTitle)
                        .shadow(radius: 0, x: 5, y: 5)
                        .scaleEffect((isCorrect != nil && isCorrect! == false) ? 1.5 : 1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1), value: (isCorrect != nil && isCorrect! == false))
                }
                Text("\(wrongAnswerCount)")
                    .font(.custom("VT323-Regular", size: 30))
                    .animation(.default, value: wrongAnswerCount)
            }
            .padding(10)
            
            VStack{
                ZStack{
                    BackgroundFrame(width: 80, height: 70)
                    Text("✅")
                        .font(.largeTitle)
                        .shadow(radius: 0, x: 5, y: 5)
                        .scaleEffect((isCorrect != nil && isCorrect!) ? 1.5 : 1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1), value: (isCorrect != nil && isCorrect!))
                }
                Text("\(correctAnswerCount)")
                    .font(.custom("VT323-Regular", size: 30))
                    .animation(.default, value: correctAnswerCount)
            }
        }
    }
}

struct QuestionNumberView: View {
    let questionAmount: Int
    @Binding var questionIndex: Int
    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    var body: some View {
        VStack(spacing: 10){
            Text("Question number")
                .font(.custom("Salsa-Regular", size: 28))
            LazyVGrid(columns: Array(repeating: GridItem(), count: 5), spacing: 1) {
                ForEach(1...questionAmount, id: \.self) { index in
                    ZStack {
                        if (index == questionIndex) {
                            Image("rounded_wd_chick")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .animation(.easeInOut(duration: 1.0), value: questionIndex)
                        }
                        Text("\(index)")
                            .font(.custom("VT323-Regular", size: 30))
                            .foregroundStyle(index == questionIndex ? .clear : (index > questionIndex ? .gray : .black))
                    }.padding(.horizontal, 8)
                }
            }.padding(10)
        }
    }
}

struct QuestionView: View {
    let tableSize: Int
    let questionAmount: Int
    
    @State private var questionIndex = 1
    @State private var multiplier1: Int
    @State private var multiplier2: Int
    @State private var correctAnswerCount = 0
    @State private var wrongAnswerCount = 0
    @State private var showingResult = false
    @State private var currectAnswer = 0
    
    // Used to animate the score button
    @State private var isCorrect: Bool?
    @State private var showingFinalScore = false
    @State private var candidatedAnswers = [Int]()
    
    static func generateCandidatedAnswers(correctAnswer: Int) -> [Int]{
        let candidateSize = 3
        
        var answers = [correctAnswer]
        var index = 1
        while index < candidateSize {
            let next = Int.random(in: 1...(correctAnswer * 2))
            if (next != correctAnswer && !answers.contains(next)){
                answers.append(next)
                index += 1
            }
        }
        return answers.shuffled()
    }
    
    func resetQuestion() {
        questionIndex = 1
        correctAnswerCount = 0
        wrongAnswerCount = 0
        showingResult = false
        currectAnswer = 0
        
        isCorrect = nil
        showingFinalScore = false
    }
    
    init(multiplicationTableCapacity: Int, questionAmount: Int) {
        self.tableSize = multiplicationTableCapacity
        self.questionAmount = questionAmount
        self._multiplier1 = State(initialValue: Int.random(in: 1...multiplicationTableCapacity))
        self._multiplier2 = State(initialValue: Int.random(in: 1...multiplicationTableCapacity))
        self._candidatedAnswers = State(initialValue: QuestionView.generateCandidatedAnswers(correctAnswer: multiplier1 * multiplier2))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundGradient()
                VStack {
                    QuestionNumberView(questionAmount: questionAmount, questionIndex: $questionIndex)
                    
                    ZStack {
                        BackgroundFrame(width: 300, height: 300)
                        VStack{
                            Text("What is the right answer?")
                                .font(.title2)
                                .padding(.bottom, 18)
                            
                            Text("\(multiplier1) x \(multiplier2)")
                                .font(.custom("Salsa-Regular", size: 35))
                                .padding(.bottom, 15)
                            
                            HStack{
                                ForEach(candidatedAnswers, id: \.self){ option in
                                    Button {
                                        currectAnswer = option
                                        judgeAnswer(answer: option)
                                    } label: {
                                        ZStack {
                                            BackgroundCircle(size: 60)
                                                .rotationEffect(option == currectAnswer && showingResult ? Angle.degrees(360) : Angle.degrees(0))
                                                .animation(.easeOut(duration: 1), value: currectAnswer)
                                            Text("\(option)")
                                                .font(.custom("Montserrat-Regular", size: 24))
                                                .foregroundStyle(.white)
                                                .animation(.bouncy, value: showingResult)
                                        }
                                    }
                                }
                            }.disabled(showingResult)
                        }
                    }
                    
                    ScoreView(isCorrect: $isCorrect, wrongAnswerCount: $wrongAnswerCount, correctAnswerCount: $correctAnswerCount)
                }.alert("Final score", isPresented: $showingFinalScore){
                    NavigationLink("Play Again"){
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                    }
                } message: {
                    Text ("Game is over. Your final score is \(correctAnswerCount)/\(questionAmount)")
                }.onAppear {
                    resetQuestion()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func judgeAnswer(answer: Int) {
        if answer == multiplier1 * multiplier2 {
            correctAnswerCount += 1
            isCorrect = true
        }else{
            wrongAnswerCount += 1
            isCorrect = false
        }
        showingResult = true
        
        // Show the result message after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        showingFinalScore = (questionIndex > questionAmount)
        
        if(!showingFinalScore) {
            isCorrect = nil
            showingResult = false
            multiplier1 = Int.random(in: 1...tableSize)
            multiplier2 = Int.random(in: 1...tableSize)
            candidatedAnswers = QuestionView.generateCandidatedAnswers(correctAnswer: multiplier1 * multiplier2)
        }
    }
}

#Preview {
    QuestionView(multiplicationTableCapacity: 5, questionAmount: 5)
}
