//
//  City_SightsApp.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/8/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
