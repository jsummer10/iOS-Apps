//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/20/22.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
            
                // MARK: Ingredients
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical, 10.0)
                    
                    ForEach(recipe.ingredients, id:\.self) { item in
                        Text("• " + item)
                            .padding(.vertical, 1.0)
                    }
                }
                .padding(.horizontal, 30.0)
                
                // MARK: Divider
                Divider()
                    .padding(.vertical, 10)
                
                // MARK: Directions
                VStack(alignment: .leading) {
                    Text("Directions")
                        .font(.headline)
                        .padding(.vertical, 10.0)
                    
                    ForEach(0 ..< recipe.directions.count, id:\.self) { i in
                        Text(String(i+1) + ". " + recipe.directions[i])
                            .padding(.vertical, 1.0)
                    }
                }
                .padding(.horizontal, 30.0)
            }
        }.navigationBarTitle(recipe.name)
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = RecipeModel()
        RecipeDetailView(recipe: model.recipes[0])
    }
}
