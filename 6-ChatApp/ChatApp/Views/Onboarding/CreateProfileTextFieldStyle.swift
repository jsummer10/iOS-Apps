//
//  CreateProfileTextFieldStyle.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import Foundation
import SwiftUI

struct CreateProfileTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 56)
            
            configuration
                .font(Font.tabBar)
                .padding()
        }
    }
    
}
