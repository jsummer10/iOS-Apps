//
//  RecipeModel.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/15/22.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    init() {
        let recipe = Recipe(name: "BLT",
                            ingredients: ["Bread", "Bacon", "Lettuce", "Tomatoes", "Mayonnaise"],
                            steps: ["1) Put mayonnaise on bread", "2) put other ingredients on bread"])
        
        recipes.append(recipe)
    }
    
    func addRecipe(name: String) {
        recipes.append(Recipe(name: name))
    }
    
}
