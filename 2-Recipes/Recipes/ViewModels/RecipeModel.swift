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
        self.recipes = DataServices.parseJSON()
    }
}
