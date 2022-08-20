//
//  ContentView.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/14/22.
//

import SwiftUI

struct MainMenuView: View {

    @ObservedObject var model = RecipeModel()

    var body: some View {
        VStack {
            NavigationView {
                List(model.recipes) { recipe in
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
                    )
                    
                }.navigationTitle(Text("Recipes"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
