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
    
    static func getPortion(ingredient: Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion       = ""
        var numerator     = ingredient.num ?? 1
        var denominator   = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            denominator *= recipeServings
            numerator   *= targetServings
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator   /= divisor
            denominator /= divisor
            
            if numerator >= denominator {
                wholePortions = numerator / denominator
                numerator = numerator % denominator
                portion += String(wholePortions)
            }
            
            if numerator > 0 {
                portion +=  wholePortions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
        }
        
        if var unit = ingredient.unit {
            if wholePortions <= 1 {}
            else if unit.suffix(2) == "ch" { unit += "es" }
            else if unit.suffix(1) == "f"  { unit = String(unit.dropLast()) + "ves" }
                
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            return portion + unit
        }
        
        return portion
    }
}
