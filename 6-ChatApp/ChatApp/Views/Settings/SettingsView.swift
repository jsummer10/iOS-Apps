//
//  SettingsView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isSettingsShowing: Bool
    @Binding var isOnboarding: Bool
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
