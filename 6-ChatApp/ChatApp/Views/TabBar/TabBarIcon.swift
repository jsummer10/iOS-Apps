//
//  TabBarIcon.swift
//  ChatApp
//
//  Created by Jacob Summerville on 12/31/22.
//

import SwiftUI

struct TabBarIcon: View {
    var icon       : String
    var text       : String
    var centerBtn  : Bool = false
    var currentTab : Bool = false
    
    var body: some View {
        let tintColor = centerBtn ? "icons-primary" : "icons-secondary"
        let iconSize = centerBtn ? 32.0 : 24.0
        
        GeometryReader { geo in
            
            if (!centerBtn && currentTab) {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/3, height: 4)
                    .padding(.leading, geo.size.width/3)
            }
            
            VStack(alignment: .center, spacing: 4){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                
                Text(text)
                    .font(Font.tabBar)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
        }.tint(Color(tintColor))
    }
}
