//
//  ContactRow.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/9/23.
//

import SwiftUI

struct ContactRow: View {
    
    var user: User
    
    var body: some View {
        HStack (spacing: 24) {
            
            // profile image
            ProfilePicView(user: user)
            
            VStack (alignment: .leading, spacing: 4) {
                // name
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                // phone number
                Text(user.phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // extra space
            Spacer()
        }
    }
}
