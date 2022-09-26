//
//  TestResultView.swift
//  Learning
//
//  Created by Jacob Summerville on 9/25/22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    var numCorrect: Int
    
    var resultHeading: String {
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Float(numCorrect) / Float(model.currentModule!.test.questions.count)
        
        if pct > 0.9 {
            return "Awesome!"
        } else if pct > 0.7 {
            return "You did well!"
        } else {
            return "Keep practicing!"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            
            Button {
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }.padding()

            Spacer()
        }
    }
}
