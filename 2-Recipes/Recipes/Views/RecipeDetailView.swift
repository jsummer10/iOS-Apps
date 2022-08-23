//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/20/22.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    @State var servings = 2
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: Recipe Title
                Text(recipe.name)
                    .bold()
                    .padding(.leading)
                    .padding(.top, 20)
                    .font(.title)
                
                // MARK: Serving Picker
                Text("Servings")
                    .padding(.top, 10.0)
                    .padding(.horizontal, 30)
                
                VStack {
                    Picker("Servings", selection: $servings) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }.pickerStyle(SegmentedPickerStyle())
                        .frame(width: 180)
                }
                .padding(.horizontal, 30.0)
                .padding(.bottom, 10)
                
                // MARK: Ingredients
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical, 10.0)
                    
                    ForEach(recipe.ingredients) { item in
                        Text("• " + RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: servings) + " " + item.name.lowercased())
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
                    
                    ForEach(0..<recipe.directions.count, id:\.self) { i in
                        Text(String(i+1) + ". " + recipe.directions[i])
                            .padding(.vertical, 1.0)
                    }
                }
                .padding(.horizontal, 30.0)
            }
        }
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = RecipeModel()
        RecipeDetailView(recipe: model.recipes[0])
    }
}
