//
//  Recipe.swift
//  Recipes
//
//  Created by Jacob Summerville on 8/15/22.
//

import Foundation

struct Recipe: Identifiable {
    
    var id = UUID()
    var name = ""
    var ingredients: [String] = []
    var steps: [String] = []
    
}
