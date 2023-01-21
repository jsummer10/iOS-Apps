//
//  CreateProfileTextFieldStyle.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import Foundation
import SwiftUI

struct CreateProfileTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            // This references the textfield
            configuration
                .font(Font.tabBar)
                .padding()
        }
    }
}
