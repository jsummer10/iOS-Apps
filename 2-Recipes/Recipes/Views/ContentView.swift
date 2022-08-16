//
//  ContentView.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/14/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var model = RecipeModel()

    var body: some View {
        VStack {
            NavigationView {
                List(model.recipes) { recipe in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Text(recipe.name)
                        }
                    )
                    
                }.navigationTitle(Text("Recipes"))
            }
            
            Button("Add Recipe") {
                model.addRecipe(name: "Burger")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
