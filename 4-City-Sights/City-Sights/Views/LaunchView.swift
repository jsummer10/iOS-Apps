//
//  LaunchView.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/8/22.
//

import CoreLocation
import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.authorizationState == .notDetermined {
            
        } else if model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse{
            HomeView()
        } else if model.authorizationState == CLAuthorizationStatus.denied {
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
