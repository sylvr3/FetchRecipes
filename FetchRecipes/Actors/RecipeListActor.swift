//
//  RecipeListActor.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/18/24.
//

import Foundation

// Actor to manage state safely using Swift concurrency
actor RecipeListActor {
    private(set) var recipes: [Recipe] = [] // The list of recipes is protected within the actor

    // Update recipes
    func updateRecipes(newRecipes: [Recipe]) {
        self.recipes = newRecipes
    }
}



