//
//  ContentView.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/14/22.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(model.recipes) { recipe in
                            NavigationLink(
                                destination: RecipeDetailView(recipe: recipe),
                                label: {
                                    HStack {
                                        Image(recipe.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipped()
                                            .cornerRadius(5)
                                        Text(recipe.name)
                                    }
                                }
                            ).buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding(.leading)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
