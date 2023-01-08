//
//  TabBar.swift
//  ChatApp
//
//  Created by Jacob Summerville on 12/31/22.
//

import SwiftUI

enum Tabs : Int {
    case chats = 0
    case contacts = 1
}

struct TabBar: View {
    @Binding var selectedTab : Tabs
    
    var body: some View {
        HStack (alignment: .center) {
            Button {
                selectedTab = .chats
            } label: {
                TabBarIcon(icon: "bubble.left", text: "Chats", currentTab: selectedTab == .chats)
            }
    
            Button {
                // TODO: Test purposes
                AuthViewModel.logout()
            } label: {
                TabBarIcon(icon: "plus.circle.fill", text: "New Chat", centerBtn: true)
            }
            
            Button {
                selectedTab = .contacts
            } label: {
                TabBarIcon(icon: "person", text: "Contacts", currentTab: selectedTab == .contacts)
            }
        }
        .frame(height: 82)
    }
}
