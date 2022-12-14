//
//  HomeView.swift
//  Learning
//
//  Created by Jacob Summerville on 9/17/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading){
                Text("What do you want to do today?")
                    .padding(.leading, 30)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            VStack(spacing: 20){
                                NavigationLink(
                                    destination: ContentView()
                                        .onAppear(perform: {
                                            model.beginModule(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected,
                                    label: {
                                        HomeViewRow(image: module.content.image,
                                                    title: "Learn \(module.category)",
                                                    description: module.content.description,
                                                    count: "\(module.content.lessons.count) Lessons",
                                                    time: module.content.time)
                                    })
                                
                                NavigationLink(
                                    destination: TestView().onAppear(perform: { model.beginTest(module.id)
                                    }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    label: {
                                        HomeViewRow(image: module.test.image,
                                                    title: "Test \(module.category)",
                                                    description: module.test.description,
                                                    count: "\(module.test.questions.count) Lessons",
                                                    time: module.test.time)
                                    })
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
