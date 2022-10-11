//
//  BusinessRow.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/11/22.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                VStack (alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    
                    Text(String(format:"%.1f miles", (business.distance ?? 0)/Constants.metersInMiles))
                        .font(.caption)
                }
                
                Spacer()
                    
                VStack (alignment: .leading) {
                    Image("regular_\(Int(business.rating ?? 0.0))")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            
            Divider()
        }.foregroundColor(.black)
    }
}
