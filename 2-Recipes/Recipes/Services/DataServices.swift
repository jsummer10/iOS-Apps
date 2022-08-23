//
//  DataServices.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/17/22.
//

import Foundation

class DataServices {
    
    static func parseJSON() -> [Recipe] {
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
    
        guard pathString != nil else {
           return [Recipe]()
        }
        
        let url = URL(fileURLWithPath: pathString!)

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            var recipeData = try decoder.decode([Recipe].self, from: data)

            // Add unique IDs
            for i in recipeData.indices {
                recipeData[i].id = UUID()
                for j in recipeData[i].ingredients.indices {
                    recipeData[i].ingredients[j].id = UUID()
                }
            }
            
            return recipeData
        } catch {
            print("An error ocurred while parsing JSON data")
            print(error)
        }
        
        return [Recipe]()
    }
    
}
