//
//  ContentDetailView.swift
//  Learning
//
//  Created by Jacob Summerville on 9/18/22.
//

import SwiftUI
import AVKit // added through project properties > general > Frameworks, Libraries, and Embedded Content > AVKit.framework

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // only show video if url is valid
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
            }
            
            CodeTextView()
            
            if model.hasNextLesson() {
                // show next lesson button
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }.padding(20)
                })
            } else {
                // show complete button
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }.padding(20)
                })
            }
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}
