//
//  OnboardingButtonStyle.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import Foundation
import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .foregroundColor(Color("button-primary"))
                .scaleEffect(configuration.isPressed ? 1.05 : 1)
                .animation(.easeOut, value: 1)
            
            configuration.label
                .font(Font.button)
                .foregroundColor(Color("text-button"))
        }
    }
}
