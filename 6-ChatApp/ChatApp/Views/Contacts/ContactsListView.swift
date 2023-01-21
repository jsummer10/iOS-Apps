//
//  ContactsListView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/8/23.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    @Binding var isSettingsShowing: Bool
    
    @State var filterText = ""
    
    var body: some View {
        VStack {
            // MARK: Contacts Heading
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
            .onChange(of: filterText) { _ in
                contactsViewModel.filterContacts(filterBy: filterText)
            }
            
            // MARK: Contact Display
            if contactsViewModel.filteredUsers.count > 0 {
                List(contactsViewModel.filteredUsers) { user in
                    Button {
                        // Display conversation view
                    } label: {
                        // Display rows
                        ContactRow(user: user)
                    }.buttonStyle(.plain)
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
