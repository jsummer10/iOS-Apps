//
//  ChatsListRow.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import SwiftUI

struct ChatsListRow: View {
    var chat: Chat
    var otherParticipants: [User]?
    
    var body: some View {
        
        HStack (spacing: 24) {
            
            // Assume at least 1 other participant in the chat
            let participant = otherParticipants?.first
            
            // Profile Image of participants
            if otherParticipants != nil && otherParticipants!.count == 1 {
                
                // Display profile image of single participant
                if participant != nil {
                    ProfilePicView(user: participant!)
                }
            }
            else if otherParticipants != nil && otherParticipants!.count > 1 {
                
                // Display group profile image
                GroupProfilePicView(users: otherParticipants!)
            }
            
            VStack (alignment: .leading, spacing: 4) {
                // Name
                if let otherParticipants = otherParticipants {
                    
                    Group {
                        if otherParticipants.count == 1 {
                            
                            Text("\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                                
                        } else if otherParticipants.count == 2 {
                            
                            let participant2 = otherParticipants[1]
                            
                            Text("\(participant!.firstname ?? ""), \(participant2.firstname ?? "")")
                                
                        } else if otherParticipants.count > 2 {
                            
                            let participant2 = otherParticipants[1]
                            
                            Text("\(participant!.firstname ?? ""), \(participant2.firstname ?? "") + \(otherParticipants.count - 2) others")
                                
                        }
                    }
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                }
                // last message
                Text(chat.lastmsg ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra space
            Spacer()
            
            // Timestamp
            Text(chat.updated == nil ? "" :
                    DateUtil.chatTimestampFrom(date: chat.updated!))
                .font(Font.bodyParagraph)
                .foregroundColor(Color("text-input"))
        }
        
    }
}
