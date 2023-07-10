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
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                // Chat header
                ZStack {
                    
                    Color("view-header-background")
                        .ignoresSafeArea()
                    
                    HStack {
                        VStack (alignment: .leading) {
                            
                            HStack {
                                // Back arrow
                                Button {
                                    // Dismiss chat window
                                    isChatShowing = false
                                    
                                } label: {
                                    Image(systemName: "arrow.backward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("text-header"))
                                }
                                
                                // Label for new message
                                if participants.count == 0 {
                                    Text("New Message")
                                        .font(Font.chatHeading)
                                        .foregroundColor(Color("text-header"))
                                }
                            }
                            .padding(.bottom, 16)
                            
                            // Name
                            if participants.count > 0 {
                                
                                let participant = participants.first
                                
                                Group {
                                    if participants.count == 1 {
                                    
                                        Text("\(participant?.firstname ?? "") \(participant?.lastname ?? "")")
                                    }
                                    else if participants.count == 2 {
                                        
                                        let participant2 = participants[1]
                                        
                                        Text("\(participant?.firstname ?? ""), \(participant2.firstname ?? "")")
                                    }
                                    else if participants.count > 2 {
                                        
                                        let participant2 = participants[1]
                                        
                                        Text("\(participant?.firstname ?? ""), \(participant2.firstname ?? "") + \(participants.count - 2) others")
                                            
                                    }
                                }
                                .font(Font.chatHeading)
                                .foregroundColor(Color("text-header"))
                                
                            }
                            else {
                                // New message
                                Text("Recipient")
                                    .font(Font.bodyParagraph)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        
                        Spacer()
                        
                        // Profile image
                        if participants.count == 1 {
                            
                            let participant = participants.first
                            // Display a single profile image
                            ProfilePicView(user: participant!)
                        }
                        else if participants.count > 1 {
                            // Display group profile images
                            GroupProfilePicView(users: participants)
                        }
                        else {
                            // New message
                            Button {
                                // Show contact picker
                                isContactsPickerShowing = true
                                
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color("button-primary"))
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
                }
                .frame(height: 104)
                
                // Chat log
                
                ScrollViewReader { proxy in
                    
                    ScrollView {
                        
                        VStack (spacing: 24) {
                            
                            ForEach (Array(chatViewModel.messages.enumerated()), id: \.element) { index, msg in
                                
                                let isFromUser = msg.senderid == AuthViewModel.getLoggedInUserId()
                                
                                // Dynamic message
                                HStack {
                                    
                                    if isFromUser {
                                        // Timestamp
                                        Text(DateUtil.chatTimestampFrom(date: msg.timestamp))
                                            .font(Font.smallText)
                                            .foregroundColor(Color("text-timestamp"))
                                            .padding(.trailing)
                                        
                                        Spacer()
                                    }
                                    else if participants.count > 1 {
                                        
                                        // This is a group chat and not a message from the user
                                        // Display profile photo
                                        let userOfMsg = participants.filter { p in
                                            p.id == msg.senderid
                                        }.first
                                        if let userOfMsg = userOfMsg {
                                            ProfilePicView(user: userOfMsg)
                                                .padding(.trailing, 16)
                                        }
                                    }
                                    
                                    let userOfMsg = participants.filter { p in
                                        p.id == msg.senderid
                                    }.first
                                    
                                    if msg.imageurl != "" {
                                        // Photo Message
                                        
                                        ConversationPhotoMessage(imageUrl: msg.imageurl!,
                                                                 isFromUser: isFromUser,
                                                                 isActive: userOfMsg?.isactive ?? true)
                                        
                                    }
                                    else {
                                        // Text Message
                                        
                                        // Determine if it's a group chat and a msg from another user
                                        if participants.count > 1 && !isFromUser {
                                            
                                            
                                            // Show a text msg with name
                                            ConversationTextMessage(msg: msg.msg,
                                                                    isFromUser: isFromUser,
                                                                    name: "\(userOfMsg?.firstname ?? "") \(userOfMsg?.lastname ?? "")",
                                                                    isActive: userOfMsg?.isactive ?? true)
                                        }
                                        else {
                                            // Text message with no name
                                            ConversationTextMessage(msg: msg.msg,
                                                                    isFromUser: isFromUser)
                                        }
                                    }
                                    
                                    if !isFromUser {
                                        
                                        Spacer()
                                        
                                        Text(DateUtil.chatTimestampFrom(date: msg.timestamp))
                                            .font(Font.smallText)
                                            .foregroundColor(Color("text-timestamp"))
                                            .padding(.leading)
                                    }
                                    
                                }
                                .id(index)
                                
                                
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 24)
                        
                    }
                    .onChange(of: chatViewModel.messages.count) { newCount in
                        
                        withAnimation {
                            proxy.scrollTo(newCount - 1)
                        }
                    }
                }
                
                
                // Chat message bar
                
                HStack (spacing: 15) {
                    // Camera button
                    Button {
                        // Show picker
                        isSourceMenuShowing = true
                        
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }
                    
                    // Textfield
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                        
                        if selectedImage != nil {
                            
                            // Display image in message bar
                            Text("Image")
                                .foregroundColor(Color("text-input"))
                                .font(Font.bodyParagraph)
                                .padding(10)
                            
                            // Delete button
                            HStack {
                                Spacer()
                                
                                Button {
                                    // Delete the image
                                    selectedImage = nil
                                    
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("text-input"))
                                }
                            }
                            .padding(.trailing, 12)
                        } else {
                            
                            TextField("Type your message", text: $chatMessage)
                                .foregroundColor(Color("text-input"))
                                .font(Font.bodyParagraph)
                                .padding(10)
                            
                        }
                        
                        
                    }
                    .frame(height: 44)
                    
                    
                    // Send button
                    Button {
                        
                        // Check if image is selected, if so send image
                        
                        if selectedImage != nil {
                            
                            // Send image message
                            chatViewModel.sendPhotoMessage(image: selectedImage!)
                            
                            // Clear image
                            selectedImage = nil
                        } else {
                            // Send text message
                            
                            // Clean up text msg
                            chatMessage = chatMessage.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            // Send message
                            chatViewModel.sendMessage(msg: chatMessage)
                            
                            // Clear textbox
                            chatMessage = ""
                        }
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }
                    .disabled(chatMessage.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
                              selectedImage == nil)
                }
                .disabled(participants.count == 0)
                .padding(.horizontal)
                .frame(height: 76)
            }
        }
        .onAppear {
            // Call chat view model to retrieve all chat messages
            chatViewModel.getMessages()
            
            // Try to get the other participants as User instances
            let ids = chatViewModel.getParticipantIds()
            self.participants = contactsViewModel.getParticipants(ids: ids)
            
        }
        .onDisappear {
            
            // Do any necesary clean up before conversation view disappears
            chatViewModel.conversationViewCleanup()
        }
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                // Set the source to photo library
                self.source = .photoLibrary
                
                // Show the image picker
                isPickerShowing = true
                
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                Button {
                    // Set the source to camera
                    self.source = .camera
                    
                    // Show the image picker
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }
            
            
        })
        .sheet(isPresented: $isPickerShowing) {
            // Show the image picker
            ImagePicker(selectedImage: $selectedImage,
                        isPickerShowing: $isPickerShowing, source: self.source)
        }
        .sheet(isPresented: $isContactsPickerShowing) {
            // When sheet is dismissed
            if participants.count > 0 {
                // Search for the conversation with selected participants
                chatViewModel.getChatFor(contacts: participants)
            }
        } content: {
            ContactsPicker(isContactsPickerShowing: $isContactsPickerShowing,
                           selectedContacts: $participants)
        }
    }
}
