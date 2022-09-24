//
//  TestView.swift
//  Learning
//
//  Created by Jacob Summerville on 9/23/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack (alignment: .leading){
                Text("Question \(model.currentQuestionIndex + 1) of  \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                CodeTextView()
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { i in

                            Button {
                                // save selected answer
                                selectedAnswerIndex = i
                            } label: {
                                ZStack {
                                    if !submitted {
                                        // still selecting answer
                                        RectangleCard(color: i == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    } else if i == selectedAnswerIndex && i == model.currentQuestion!.correctIndex {
                                        // correct answer selected
                                        RectangleCard(color: .green)
                                            .frame(height: 48)
                                    } else if i == selectedAnswerIndex && i != model.currentQuestion!.correctIndex {
                                        // wrong answer selected
                                        RectangleCard(color: .red)
                                            .frame(height: 48)
                                    } else if i == model.currentQuestion!.correctIndex {
                                        // show correct answer
                                        RectangleCard(color: .green)
                                            .frame(height: 48)
                                    } else {
                                        RectangleCard()
                                            .frame(height: 48)
                                    }
                                    
                                    Text(model.currentQuestion!.answers[i])
                                }.padding(.horizontal, 10)
                            }.disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding(5)
                }
                
                Button {
                    submitted = true
                    
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                                .frame(height: 48)
                        Text("Submit")
                            .foregroundColor(.white)
                            .bold()
                    }.padding(.horizontal, 15)
                }.disabled(selectedAnswerIndex == nil)
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        } else {
            // Test hasn't loaded yet
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
