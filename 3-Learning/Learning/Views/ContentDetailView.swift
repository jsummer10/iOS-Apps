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
        
        // only show video if url is valid
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
        }
        
        // show next lesson button if applicable
        if model.hasNextLesson() {
            Button(action: {
                model.nextLesson()
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                        .foregroundColor(.white)
                        .bold()
                }.padding(20)
            })
        }
    }
}
