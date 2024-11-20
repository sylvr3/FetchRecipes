//
//  RecipeListResponse.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/18/24.
//

import Foundation

// Used to retrieve the response and store Recipes into an array
struct RecipeListResponse: Decodable {
    let recipes: [Recipe]
}
