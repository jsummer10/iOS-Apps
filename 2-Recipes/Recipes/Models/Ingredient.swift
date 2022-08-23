//
//  Ingredient.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/20/22.
//

import Foundation

class Ingredient: Identifiable, Decodable {
    
    var id    : UUID?     // optional property
    var name  : String
    var num   : Int?
    var denom : Int?
    var unit  : String?
    
}
