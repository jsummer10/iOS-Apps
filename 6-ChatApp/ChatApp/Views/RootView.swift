//
//  ContentView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 12/31/22.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab : Tabs = .chats
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                switch selectedTab {
                case .chats:
                    ChatsListView()
                case .contacts:
                    ContactsListView()
                }
                
                // create a tab bar on the bottom of the screen
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }
        }.fullScreenCover(isPresented: $isOnboarding) {
            // on dismiss
        } content: {
            OnboardingContainerView(isOnboarding: $isOnboarding)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
