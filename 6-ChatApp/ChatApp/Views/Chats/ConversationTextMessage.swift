//
//  ConversationTextMessage.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import SwiftUI

struct ConversationTextMessage: View {
    var msg: String
    var isFromUser: Bool
    var name: String?
    var isActive: Bool = true
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 4) {
            // Name
            if let name = name {
                Text(name)
                    .font(Font.chatName)
                    .foregroundColor(Color("bubble-primary"))
            }
            
            // Text
            Text(isActive ? msg : "Message deleted")
                .font(Font.bodyParagraph)
                .foregroundColor(isFromUser ? Color("text-button") : Color("text-secondary"))
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
        .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
    }
}
