//
//  LearningApp.swift
//  Learning
//
//  Created by Jacob Summerville on 9/17/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
