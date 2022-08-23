//
//  MainView.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/20/22.
//

import SwiftUI

struct MainView: View {
    
    @State var tabIndex = 1 // allows you to change the default tab
    
    var body: some View {
        // tabIndex is binded to TabView with "$"
        TabView (selection: $tabIndex){
            
            // MARK: Featured View
            FeaturedView()
                .tabItem{
                    VStack {
                        Image(systemName: "star")
                        Text("Featured")
                    }
                }.tag(0)
            
            // MARK: Recipe List View
            RecipeListView()
                .tabItem{
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Recipes")
                    }
                }.tag(0)
        }.environmentObject(RecipeModel())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
