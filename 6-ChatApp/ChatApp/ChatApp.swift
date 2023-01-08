//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Jacob Summerville on 12/31/22.
//

import SwiftUI
import Firebase

@main
struct ChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ContactsViewModel())
        }
    }
}
