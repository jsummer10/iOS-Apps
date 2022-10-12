//
//  YelpAttribution.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/12/22.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link: String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        }
    }
}
