//
//  ConversationView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isContactsPickerShowing = false
    
    @State var chatMessage = ""
    @State var participants = [User]()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
