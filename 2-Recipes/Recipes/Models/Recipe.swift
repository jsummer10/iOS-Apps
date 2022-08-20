//
//  Recipe.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/15/22.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    
    var id          : UUID?     // optional property
    var name        : String
    var featured    : Bool
    var image       : String
    var description : String
    var prepTime    : String
    var cookTime    : String
    var totalTime   : String
    var servings    : Int
    var ingredients : [String]
    var directions  : [String]

}
