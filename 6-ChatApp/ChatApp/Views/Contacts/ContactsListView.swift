//
//  ContactsListView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/8/23.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel : ContactsViewModel
    @State var filterText = ""
    
    var body: some View {
        VStack {
            // MARK: Contacts Screen
            HStack {
                Text("Contacts")
                    .font(Font.pageTitle)
                
                Spacer()
                
                Button {
                    // Settings
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            }

            // MARK: Search Bar
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                
                TextField("Search contact or number", text: $filterText)
                    .font(Font.tabBar)
                    .foregroundColor(Color("text-textfield"))
                    .padding()
            }
            .frame(height: 46)
            
            if contactsViewModel.users.count > 0 {
                // MARK: List
                List(contactsViewModel.users) { user in
                    // Display rows
                    Text(user.firstname ?? "Test User")
                }.listStyle(.plain)
            } else {
                Spacer()
                
                Image("no-contacts-yet")
                
                Text("Hmmm... Zero Contacts")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Try saving some contacts on your phone!")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                Spacer()
            }
            
        }
        .padding(.horizontal)
        .onAppear {
            contactsViewModel.getLocalContacts()
        }
    }
}
