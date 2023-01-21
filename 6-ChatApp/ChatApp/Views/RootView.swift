//
//  ContentView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 12/31/22.
//

import SwiftUI

struct RootView: View {
    
    // For detecting when the app state changes
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    @State var isChatShowing = false
    @State var isSettingsShowing = false
    
    var body: some View {
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                case .chats:
                    ChatsListView(isChatShowing: $isChatShowing,
                                  isSettingsShowing: $isSettingsShowing)
                case .contacts:
                    ContactsListView(isChatShowing: $isChatShowing,
                                     isSettingsShowing: $isSettingsShowing)
                }
                
                Spacer()
                
                TabBar(selectedTab: $selectedTab, isChatShowing: $isChatShowing)
            }
        }
        .onAppear(perform: {
            if !isOnboarding {
                // User has already onboarded, load contacts
                contactsViewModel.getLocalContacts()
            }
        })
        .fullScreenCover(isPresented: $isOnboarding) {
            // On dismiss
        } content: {
            // The onboarding sequence
            OnboardingContainerView(isOnboarding: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            
            // The conversation view
            ConversationView(isChatShowing: $isChatShowing)
        }
        .fullScreenCover(isPresented: $isSettingsShowing, onDismiss: nil, content: {
            
            // The Settings View
            SettingsView(isSettingsShowing: $isSettingsShowing,
                         isOnboarding: $isOnboarding)
        })
        .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
                chatViewModel.chatListViewCleanup()
            }
        }
        
    }
}
